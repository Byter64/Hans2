module sd_axi_lite #(
    parameter BASE_ADDR = 32'h8000_0000,
    parameter input_clock_speed = 50_000_000,
    parameter slow_clk_frequency = 400_000,
    parameter fast_clk_frequency = 25_000_000
)(
    input  logic aclk, aresetn,
    
    // AXI Write Channel
    input  logic [31:0] awaddr,
    input  logic awvalid,
    output logic awready,
    input  logic [31:0] wdata,
    input  logic [3:0] wstrb,
    input  logic wvalid,
    output logic wready,
    output logic [1:0] bresp,
    output logic bvalid,
    input  logic bready,
    
    // AXI Read Channel
    input  logic [31:0] araddr,
    input  logic arvalid,
    output logic arready,
    output logic [31:0] rdata,
    output logic [1:0] rresp,
    output logic rvalid,
    input  logic rready,
    
    // SD Card Interface
    output logic sd_sclk, sd_mosi, sd_cs_n,
    input  logic sd_miso
);

    logic [3:0]  mem_we;
    logic [6:0]  mem_waddr;
    logic [31:0] mem_wdata;
    logic [6:0]  mem_raddr;
    logic [31:0] mem_rdata;
    
    (* ram_style = "logic" *)
    logic [31:0] sector_buffer [0:127];
    
    always_ff @(posedge aclk) begin
        if (mem_we[0]) sector_buffer[mem_waddr][7:0]   <= mem_wdata[7:0];
        if (mem_we[1]) sector_buffer[mem_waddr][15:8]  <= mem_wdata[15:8];
        if (mem_we[2]) sector_buffer[mem_waddr][23:16] <= mem_wdata[23:16];
        if (mem_we[3]) sector_buffer[mem_waddr][31:24] <= mem_wdata[31:24];
        mem_rdata <= sector_buffer[mem_raddr];
    end

    logic hw_init_done, hw_init_err, hw_read_reinit_req;
    logic ctrl_reinit_req;
    
    logic spi_start, spi_busy, spi_slow_clk;
    logic [7:0] spi_tx_data, spi_rx_data;
    
    logic hw_init_spi_start, hw_init_sd_cs_n, hw_init_spi_slow_clk;
    logic [7:0] hw_init_spi_tx_data;
    
    logic hw_read_mem_we;
    logic [8:0] hw_read_mem_waddr;
    logic [7:0] hw_read_mem_wdata;
    logic hw_read_start, hw_read_busy, hw_read_err, hw_read_spi_start, hw_read_sd_cs_n;
    logic [3:0] hw_read_err_code;
    logic [31:0] hw_read_sector;
    logic [7:0] hw_read_spi_tx_data;
    
    logic [8:0] hw_write_mem_raddr;
    logic [7:0] hw_write_mem_rdata; // Multiplexed byte for the 8-bit writer
    logic hw_write_start, hw_write_busy, hw_write_err, hw_write_spi_start, hw_write_sd_cs_n;
    logic [3:0] hw_write_err_code;
    logic [31:0] hw_write_sector;
    logic [7:0] hw_write_spi_tx_data;

    logic cache_valid, cache_dirty, is_write, top_mem_we;
    logic [31:0] cached_sector, req_addr, req_data, read_val;
    logic [3:0] req_strb;
    logic [3:0] last_err_code;

    logic aw_full, w_full, ar_full;
    logic [31:0] aw_latch, w_latch, ar_latch;
    logic [3:0] wstrb_latch;

    typedef enum logic [4:0] {
        S_IDLE, 
        S_CACHE_CHECK, S_FLUSH_START, S_FLUSH_WAIT_B, S_FLUSH_WAIT_D,
        S_FETCH_START, S_FETCH_WAIT_B, S_FETCH_WAIT_D,
        S_BRAM_RW_EXEC, S_BRAM_R_WAIT1, S_BRAM_R_STORE,
        S_CTRL_EXEC, S_FINISH_OK, S_FINISH_ERR, S_WAIT_BREADY, S_WAIT_RREADY
    } state_t;
    state_t state;
    
    always_ff @(posedge aclk) begin
        if (!aresetn) awready <= 0;
        else if (awvalid && !awready && !aw_full) awready <= 1;
        else awready <= 0;
        
        if (!aresetn) aw_full <= 0;
        else if (awvalid && awready) begin
            aw_full <= 1;
            aw_latch <= awaddr;
        end
        else if (state == S_IDLE && aw_full && w_full) aw_full <= 0;
    end

    always_ff @(posedge aclk) begin
        if (!aresetn) wready <= 0;
        else if (wvalid && !wready && !w_full) wready <= 1;
        else wready <= 0;
        
        if (!aresetn) w_full <= 0;
        else if (wvalid && wready) begin
            w_full <= 1;
            w_latch <= wdata;
            wstrb_latch <= wstrb;
        end
        else if (state == S_IDLE && aw_full && w_full) w_full <= 0;
    end

    always_ff @(posedge aclk) begin
        if (!aresetn) arready <= 0;
        else if (arvalid && !arready && !ar_full) arready <= 1;
        else arready <= 0;
        
        if (!aresetn) ar_full <= 0;
        else if (arvalid && arready) begin
            ar_full <= 1;
            ar_latch <= araddr; 
        end
        else if (state == S_IDLE && ar_full && !(aw_full && w_full)) ar_full <= 0; 
    end

    always_comb begin
        mem_we    = 4'b0000;
        mem_waddr = req_addr[8:2];
        mem_wdata = req_data;
        mem_raddr = req_addr[8:2];
        hw_write_mem_rdata = 8'h00;

        if (hw_read_busy) begin
            mem_waddr = hw_read_mem_waddr[8:2];
            mem_wdata = {hw_read_mem_wdata, hw_read_mem_wdata, hw_read_mem_wdata, hw_read_mem_wdata}; 
            mem_we    = hw_read_mem_we ? (4'b0001 << hw_read_mem_waddr[1:0]) : 4'b0000;
        end 
        else if (hw_write_busy) begin
            mem_raddr = hw_write_mem_raddr[8:2];
            hw_write_mem_rdata = (hw_write_mem_raddr[1:0] == 2'b00) ? mem_rdata[7:0]   :
                                  (hw_write_mem_raddr[1:0] == 2'b01) ? mem_rdata[15:8]  :
                                  (hw_write_mem_raddr[1:0] == 2'b10) ? mem_rdata[23:16] : 
                                                                        mem_rdata[31:24];
        end 
        else begin
            mem_we    = top_mem_we ? req_strb : 4'b0000;
            mem_waddr = req_addr[8:2];
            mem_wdata = req_data;
            mem_raddr = req_addr[8:2];
        end

        // SPI Signal multiplexer
        if (!hw_init_done || hw_init_err) begin
            spi_start = hw_init_spi_start;
            spi_tx_data = hw_init_spi_tx_data;
            sd_cs_n = hw_init_sd_cs_n;
            spi_slow_clk = hw_init_spi_slow_clk;
        end else if (hw_read_busy) begin
            spi_start = hw_read_spi_start;
            spi_tx_data = hw_read_spi_tx_data;
            sd_cs_n = hw_read_sd_cs_n;
            spi_slow_clk = 0;
        end else if (hw_write_busy) begin
            spi_start = hw_write_spi_start;
            spi_tx_data = hw_write_spi_tx_data;
            sd_cs_n = hw_write_sd_cs_n;
            spi_slow_clk = 0;
        end else begin
            spi_start = 0;
            spi_tx_data = 8'hFF;
            sd_cs_n = 1;
            spi_slow_clk = 0;
        end
    end

    spi_master #(
        input_clock_speed,
        slow_clk_frequency,
        fast_clk_frequency
    ) spi_inst (
        .clk(aclk),
        .rst(~aresetn),
        .slow_clk(spi_slow_clk), 
        .start(spi_start),
        .tx_data(spi_tx_data),
        .rx_data(spi_rx_data), 
        .busy(spi_busy),
        .sclk(sd_sclk),
        .mosi(sd_mosi),
        .miso(sd_miso)
    );

    sd_hw_init sd_hw_init_inst (
        .clk(aclk),
        .rst(~aresetn | hw_read_reinit_req | ctrl_reinit_req),
        .spi_start(hw_init_spi_start),
        .spi_tx_data(hw_init_spi_tx_data),
        .spi_rx_data(spi_rx_data),
        .spi_busy(spi_busy),
        .init_done(hw_init_done),
        .init_err(hw_init_err),
        .sd_cs_n(hw_init_sd_cs_n),
        .spi_slow_clk(hw_init_spi_slow_clk));

    sd_hw_read sd_hw_read_inst (
        .clk(aclk),
        .rst(~aresetn),
        .start(hw_read_start),
        .sector(hw_read_sector),
        .init_done(hw_init_done),
        .busy(hw_read_busy),
        .err(hw_read_err),
        .err_code(hw_read_err_code),
        .reinit_req(hw_read_reinit_req),
        .mem_we(hw_read_mem_we),
        .mem_waddr(hw_read_mem_waddr),
        .mem_wdata(hw_read_mem_wdata),
        .spi_start(hw_read_spi_start),
        .spi_tx_data(hw_read_spi_tx_data),
        .spi_rx_data(spi_rx_data),
        .spi_busy(spi_busy),
        .sd_cs_n(hw_read_sd_cs_n));

    sd_hw_write sd_hw_write_inst (
        .clk(aclk),
        .rst(~aresetn),
        .start(hw_write_start),
        .sector(hw_write_sector),
        .init_done(hw_init_done),
        .busy(hw_write_busy),
        .err(hw_write_err),
        .err_code(hw_write_err_code),
        .mem_raddr(hw_write_mem_raddr),
        .mem_rdata(hw_write_mem_rdata),
        .spi_start(hw_write_spi_start),
        .spi_tx_data(hw_write_spi_tx_data),
        .spi_rx_data(spi_rx_data),
        .spi_busy(spi_busy),
        .sd_cs_n(hw_write_sd_cs_n));
    
    always_ff @(posedge aclk) begin
        if (!aresetn) begin
            state <= S_IDLE;
            cache_valid <= 0;
            cache_dirty <= 0;
            bvalid <= 0;
            rvalid <= 0;
            top_mem_we <= 0; 
            ctrl_reinit_req <= 0;
            last_err_code <= 0;
            hw_write_start <= 0;
            hw_read_start <= 0;
            is_write <= 0;
        end else begin
            ctrl_reinit_req <= 0;
            
            case (state)
                S_IDLE: begin
                    if (aw_full && w_full) begin
                        is_write <= 1;
                        req_addr <= aw_latch - BASE_ADDR;
                        req_data <= w_latch;
                        req_strb <= wstrb_latch;
                        state <= ((aw_latch - BASE_ADDR) >= 32'h7FFF_FFF0) ? S_CTRL_EXEC : S_CACHE_CHECK;
                    end else if (ar_full) begin
                        is_write <= 0;
                        req_addr <= ar_latch - BASE_ADDR;
                        state <= ((ar_latch - BASE_ADDR) >= 32'h7FFF_FFF0) ? S_CTRL_EXEC : S_CACHE_CHECK;
                    end
                end
                
                S_CTRL_EXEC: begin
                    if (is_write) begin
                        if (req_addr == 32'h7FFF_FFF4) begin
                            if (req_data[0] && req_strb[0]) begin
                                if (cache_valid && cache_dirty) state <= S_FLUSH_START;
                                else state <= S_FINISH_OK;
                            end else if (req_data[1] && req_strb[0]) begin
                                ctrl_reinit_req <= 1;
                                state <= S_FINISH_OK;
                            end else state <= S_FINISH_OK;
                        end else state <= S_FINISH_OK;
                    end else begin
                        if (req_addr == 32'h7FFF_FFF0) begin
                            read_val <= {20'd0, last_err_code, cache_dirty, cache_valid, hw_init_err, hw_init_done};
                        end else read_val <= 32'hBADC0DE1;
                        state <= S_FINISH_OK;
                    end
                end

                S_CACHE_CHECK: begin
                    if (!hw_init_done || hw_init_err) begin
                        last_err_code <= 4'hF;
                        state <= S_FINISH_ERR;
                    end
                    else if (!cache_valid || (cached_sector != {9'd0, req_addr[30:9]})) begin
                        if (cache_valid && cache_dirty) state <= S_FLUSH_START;
                        else state <= S_FETCH_START;
                    end else begin
                        state <= S_BRAM_RW_EXEC;
                    end
                end
                
                S_FLUSH_START: begin
                    hw_write_sector <= cached_sector;
                    hw_write_start <= 1;
                    state <= S_FLUSH_WAIT_B;
                end
                S_FLUSH_WAIT_B: begin
                    hw_write_start <= 0;
                    if (hw_write_busy) state <= S_FLUSH_WAIT_D; end
                S_FLUSH_WAIT_D: begin
                    if (hw_write_err) begin
                        last_err_code <= hw_write_err_code;
                        state <= S_FINISH_ERR;
                    end
                    else if (!hw_write_busy) begin
                        cache_dirty <= 0;
                        if (req_addr == 32'h7FFF_FFF4) state <= S_FINISH_OK;
                        else state <= S_FETCH_START;
                    end
                end
                
                S_FETCH_START: begin
                    hw_read_sector <= {9'd0, req_addr[30:9]};
                    hw_read_start <= 1; state <= S_FETCH_WAIT_B;
                end
                S_FETCH_WAIT_B: begin
                    hw_read_start <= 0;
                    if (hw_read_busy) state <= S_FETCH_WAIT_D;
                end
                S_FETCH_WAIT_D: begin
                    if (hw_read_err) begin
                        last_err_code <= hw_read_err_code;
                        state <= S_FINISH_ERR;
                    end
                    else if (!hw_read_busy) begin
                        cache_valid <= 1; cached_sector <= {9'd0, req_addr[30:9]};
                        state <= S_BRAM_RW_EXEC;
                    end
                end
                
                S_BRAM_RW_EXEC: begin
                    if (is_write) begin
                        top_mem_we <= 1;
                        state <= S_FINISH_OK;
                    end else begin
                        state <= S_BRAM_R_WAIT1;
                    end
                end
                
                S_BRAM_R_WAIT1: begin
                    state <= S_BRAM_R_STORE;
                end
                
                S_BRAM_R_STORE: begin
                    read_val <= mem_rdata;
                    state <= S_FINISH_OK;
                end
                
                S_FINISH_OK: begin
                    top_mem_we <= 0;
                    if (is_write) begin
                        if (req_addr < 32'h7FFF_FFF0) begin
                            cache_dirty <= 1;
                        end
                        bresp <= 2'b00;
                        bvalid <= 1;
                        state <= S_WAIT_BREADY;
                    end
                    else begin
                        rresp <= 2'b00;
                        rdata <= read_val;
                        rvalid <= 1;
                        state <= S_WAIT_RREADY;
                    end
                end
                S_FINISH_ERR: begin
                    top_mem_we <= 0;
                    if (is_write) begin
                        bresp <= 2'b10;
                        bvalid <= 1;
                        state <= S_WAIT_BREADY;
                    end
                    else begin
                        rresp <= 2'b10;
                        rdata <= 32'hDEADDEAD;
                        rvalid <= 1;
                        state <= S_WAIT_RREADY;
                    end
                end
                
                S_WAIT_BREADY: if (bready) begin
                    bvalid <= 0;
                    state <= S_IDLE;
                end
                S_WAIT_RREADY: if (rready) begin
                    rvalid <= 0;
                    state <= S_IDLE;
                end
                
                default: state <= S_IDLE;
            endcase
        end
    end

   `ifdef FORMAL

   
    logic [3:0] f_axi_rd_outstanding;
    logic [3:0] f_axi_wr_outstanding;
    logic [3:0] f_axi_awr_outstanding;

    always @(*) begin
        if (aresetn) begin
            assert(f_axi_rd_outstanding == ar_full + ((state != S_IDLE && !is_write) ? 1 : 0));
            assert(f_axi_awr_outstanding == aw_full + ((state != S_IDLE && is_write) ? 1 : 0));
            assert(f_axi_wr_outstanding == w_full + ((state != S_IDLE && is_write) ? 1 : 0));
            
            if (bvalid) assert(state == S_WAIT_BREADY && is_write);
            if (rvalid) assert(state == S_WAIT_RREADY && !is_write);
            
            if (state == S_WAIT_BREADY) assert(bvalid);
            if (state == S_WAIT_RREADY) assert(rvalid);
        end
    end
    initial begin
        awready = 0; wready = 0; arready = 0;
        bvalid = 0; rvalid = 0;
        aw_full = 0; w_full = 0; ar_full = 0;
        state = S_IDLE;
        is_write = 0;
    end

    faxil_slave #(
        .C_AXI_DATA_WIDTH(32),
        .C_AXI_ADDR_WIDTH(32),
        .F_LGDEPTH(4),
        .F_AXI_MAXWAIT(0),
        .F_AXI_MAXRSTALL(0),
        .F_AXI_MAXDELAY(0)
    ) formal_axi_checker (
        .i_clk(aclk),
        .i_axi_reset_n(aresetn),
        
        // Write Address
        .i_axi_awready(awready), 
        .i_axi_awaddr(awaddr), 
        .i_axi_awvalid(awvalid), 
        .i_axi_awprot(3'b000),
        
        // Write Data
        .i_axi_wready(wready), 
        .i_axi_wdata(wdata), 
        .i_axi_wstrb(wstrb), 
        .i_axi_wvalid(wvalid),
        
        // Write Response
        .i_axi_bresp(bresp), 
        .i_axi_bvalid(bvalid), 
        .i_axi_bready(bready),
        
        // Read Address
        .i_axi_arready(arready), 
        .i_axi_araddr(araddr), 
        .i_axi_arvalid(arvalid), 
        .i_axi_arprot(3'b000),
        
        // Read Data
        .i_axi_rresp(rresp), 
        .i_axi_rvalid(rvalid), 
        .i_axi_rdata(rdata), 
        .i_axi_rready(rready),
        
        // Internal state tracking outputs
        .f_axi_rd_outstanding(f_axi_rd_outstanding),
        .f_axi_wr_outstanding(f_axi_wr_outstanding),
        .f_axi_awr_outstanding(f_axi_awr_outstanding)
    );
`endif
endmodule

module sd_hw_write (
    input  logic clk, rst,
    input  logic start,
    input  logic [31:0] sector,
    input  logic init_done,
    
    output logic busy, err,
    output logic [3:0] err_code,
    
    output logic [8:0] mem_raddr,
    input  logic [7:0] mem_rdata,
    
    output logic spi_start,
    output logic [7:0] spi_tx_data,
    input  logic [7:0] spi_rx_data,
    input  logic spi_busy,
    output logic sd_cs_n
);

    typedef enum logic [4:0] {
        S_IDLE, S_ASSERT_CS, S_SEND_CMD, S_WAIT_R1, S_PROCESS_R1,
        S_PRE_TOKEN, S_SEND_TOKEN, S_WRITE_DATA, S_WRITE_CRC1, S_WRITE_CRC2,
        S_WAIT_DATA_RESP, S_CHECK_DATA_RESP, S_WAIT_BUSY_SD, S_CHECK_BUSY_SD, S_DESELECT,
        S_ERROR, S_SPI_START, S_SPI_WAIT_BUSY, S_SPI_WAIT
    } state_t;

    state_t state, return_state;
    logic [7:0] cmd_buf [0:6];
    logic [2:0] byte_idx;
    logic [23:0] timeout_cnt;
    logic [9:0] data_cnt;

    always_ff @(posedge clk) begin
        if (rst) begin
            state <= S_IDLE;
            busy <= 0;
            err <= 0;
            err_code <= 0;
            sd_cs_n <= 1;
            spi_start <= 0;
            mem_raddr <= 0;
        end else begin
            case (state)
                S_IDLE: begin
                    if (start) begin
                        busy <= 1;
                        err <= 0;
                        err_code <= 0;
                        if (!init_done) begin
                            err_code <= 1;
                            state <= S_ERROR;
                        end
                        else state <= S_ASSERT_CS;
                    end
                end
                
                S_ASSERT_CS: begin
                    sd_cs_n <= 0;
                    cmd_buf[0]<=8'h58;
                    cmd_buf[1]<=sector[31:24];
                    cmd_buf[2]<=sector[23:16]; 
                    cmd_buf[3]<=sector[15:8];
                    cmd_buf[4]<=sector[7:0];
                    cmd_buf[5]<=8'hFF;
                    byte_idx <= 0; state <= S_SEND_CMD;
                end
                
                S_SEND_CMD: begin
                    if (byte_idx == 6) begin
                        timeout_cnt <= 100;
                        state <= S_WAIT_R1;
                    end
                    else begin
                        spi_tx_data <= cmd_buf[byte_idx];
                        byte_idx <= byte_idx + 1;
                        return_state <= S_SEND_CMD;
                        state <= S_SPI_START;
                    end
                end
                
                S_WAIT_R1: begin
                    spi_tx_data <= 8'hFF;
                    return_state <= S_PROCESS_R1;
                    state <= S_SPI_START;
                end
                S_PROCESS_R1: begin
                    if (spi_rx_data[7] == 1'b0) begin
                        if (spi_rx_data == 0) state <= S_PRE_TOKEN;
                        else begin
                            err_code <= 2;
                            state <= S_ERROR;
                        end
                    end else begin
                        if (timeout_cnt == 0) begin
                            err_code <= 2;
                            state <= S_ERROR;
                        end
                        else begin
                            timeout_cnt <= timeout_cnt - 1;
                            state <= S_WAIT_R1;
                        end
                    end
                end
                
                S_PRE_TOKEN: begin
                    spi_tx_data <= 8'hFF;
                    return_state <= S_SEND_TOKEN;
                    state <= S_SPI_START;
                end
                
                S_SEND_TOKEN: begin
                    spi_tx_data <= 8'hFE;
                    mem_raddr <= 0; data_cnt <= 0;
                    return_state <= S_WRITE_DATA;
                    state <= S_SPI_START;
                end
                
                S_WRITE_DATA: begin
                    if (data_cnt == 512) state <= S_WRITE_CRC1;
                    else begin
                        spi_tx_data <= mem_rdata;
                        mem_raddr <= data_cnt[8:0] + 1;
                        data_cnt <= data_cnt + 1;
                        return_state <= S_WRITE_DATA;
                        state <= S_SPI_START;
                    end
                end
                
                S_WRITE_CRC1: begin
                    spi_tx_data <= 8'hFF;
                    return_state <= S_WRITE_CRC2;
                    state <= S_SPI_START;
                end
                S_WRITE_CRC2: begin
                    spi_tx_data <= 8'hFF;
                    timeout_cnt <= 100;
                    return_state <= S_WAIT_DATA_RESP;
                    state <= S_SPI_START;
                end
                
                S_WAIT_DATA_RESP: begin
                    spi_tx_data <= 8'hFF;
                    return_state <= S_CHECK_DATA_RESP;
                    state <= S_SPI_START; 
                end
                S_CHECK_DATA_RESP: begin
                    if ((spi_rx_data & 8'h1F) == 8'h05) begin
                        timeout_cnt <= 24'd5_000_000;
                        state <= S_WAIT_BUSY_SD;
                    end else if ((spi_rx_data & 8'h1F) == 8'h0B || (spi_rx_data & 8'h1F) == 8'h0D) begin
                        err <= 1;
                        err_code <= 4;
                        state <= S_ERROR;
                    end else begin
                        if (timeout_cnt == 0) begin
                            err <= 1;
                            err_code <= 5;
                            state <= S_ERROR; 
                        end
                        else begin
                            timeout_cnt <= timeout_cnt - 1;
                            state <= S_WAIT_DATA_RESP;
                        end
                    end
                end
                
                S_WAIT_BUSY_SD: begin
                    spi_tx_data <= 8'hFF;
                    return_state <= S_CHECK_BUSY_SD;
                    state <= S_SPI_START; 
                end
                S_CHECK_BUSY_SD: begin
                    if (spi_rx_data == 8'h00) begin
                        if (timeout_cnt == 0) begin
                            err <= 1;
                            err_code <= 6;
                            state <= S_ERROR; 
                        end
                        else begin
                            timeout_cnt <= timeout_cnt - 1;
                            state <= S_WAIT_BUSY_SD;
                        end
                    end else state <= S_DESELECT;
                end
                
                S_DESELECT: begin
                    sd_cs_n <= 1;
                    spi_tx_data <= 8'hFF;
                    return_state <= S_IDLE;
                    busy <= 0;
                    state <= S_SPI_START;
                end
                S_ERROR: begin
                    sd_cs_n <= 1;
                    err <= 1;
                    busy <= 0;
                    state <= S_IDLE;
                end
                
                S_SPI_START: begin
                    spi_start <= 1;
                    state <= S_SPI_WAIT_BUSY;
                end
                S_SPI_WAIT_BUSY: begin
                    spi_start <= 0;
                    if (spi_busy) state <= S_SPI_WAIT;
                end
                S_SPI_WAIT: if (!spi_busy) state <= return_state;
            endcase
        end
    end
endmodule


module sd_hw_read (
    input  logic clk, rst,
    input  logic start,
    input  logic [31:0] sector,
    input  logic init_done,
    
    output logic busy, err, reinit_req,
    output logic [3:0] err_code,
    
    output logic mem_we,
    output logic [8:0] mem_waddr,
    output logic [7:0] mem_wdata,
    
    output logic spi_start,
    output logic [7:0] spi_tx_data,
    input  logic [7:0] spi_rx_data,
    input  logic spi_busy,
    output logic sd_cs_n
);

    typedef enum logic [4:0] {
        S_IDLE, S_ASSERT_CS, S_SEND_CMD, S_WAIT_R1, S_PROCESS_R1,
        S_WAIT_TOKEN, S_READ_DATA, S_READ_CRC1, S_READ_CRC2, S_DESELECT,
        S_DONE, S_ERROR, S_SPI_START, S_SPI_WAIT_BUSY, S_SPI_WAIT
    } state_t;

    state_t state, return_state;
    logic [7:0] cmd_buf [0:6];
    logic [2:0] byte_idx;
    logic [15:0] timeout_cnt;
    logic [9:0] data_cnt;

    always_ff @(posedge clk) begin
        if (rst) begin
            state <= S_IDLE;
            busy <= 0; err <= 0; reinit_req <= 0; err_code <= 0;
            sd_cs_n <= 1; spi_start <= 0; mem_we <= 0;
        end else begin
            mem_we <= 0;
            reinit_req <= 0;

            case (state)
                S_IDLE: begin
                    if (start) begin
                        busy <= 1; err <= 0; err_code <= 0;
                        if (!init_done) begin
                            err_code <= 1; state <= S_ERROR;
                        end else begin
                            state <= S_ASSERT_CS;
                        end
                    end
                end
                
                S_ASSERT_CS: begin
                    sd_cs_n <= 0;
                    cmd_buf[0]<=8'hFF; cmd_buf[1]<=8'h51; cmd_buf[2]<=sector[31:24]; cmd_buf[3]<=sector[23:16]; 
                    cmd_buf[4]<=sector[15:8]; cmd_buf[5]<=sector[7:0]; cmd_buf[6]<=8'hFF;
                    byte_idx <= 0;
                    state <= S_SEND_CMD;
                end
                
                S_SEND_CMD: begin
                    if (byte_idx == 7) begin
                        timeout_cnt <= 100;
                        state <= S_WAIT_R1;
                    end else begin
                        spi_tx_data <= cmd_buf[byte_idx];
                        byte_idx <= byte_idx + 1;
                        return_state <= S_SEND_CMD;
                        state <= S_SPI_START;
                    end
                end
                
                S_WAIT_R1: begin
                    spi_tx_data <= 8'hFF;
                    return_state <= S_PROCESS_R1;
                    state <= S_SPI_START;
                end
                
                S_PROCESS_R1: begin
                    if (spi_rx_data[7] == 1'b0) begin
                        if (spi_rx_data == 0) begin
                            timeout_cnt <= 10000;
                            state <= S_WAIT_TOKEN;
                        end else begin
                            err_code <= 2; state <= S_ERROR;
                        end
                    end else begin
                        if (timeout_cnt == 0) begin
                            err_code <= 2; state <= S_ERROR;
                        end else begin
                            timeout_cnt <= timeout_cnt - 1;
                            state <= S_WAIT_R1;
                        end
                    end
                end
                
                S_WAIT_TOKEN: begin
                    spi_tx_data <= 8'hFF;
                    return_state <= S_WAIT_TOKEN;
                    if (spi_rx_data == 8'hFE) begin
                        data_cnt <= 0;
                        state <= S_READ_DATA;
                    end else if (timeout_cnt == 0) begin
                        err_code <= 3; state <= S_ERROR;
                    end else begin
                        timeout_cnt <= timeout_cnt - 1;
                        state <= S_SPI_START;
                    end
                end
                
                S_READ_DATA: begin
                    spi_tx_data <= 8'hFF;
                    return_state <= S_READ_DATA;
                    if (data_cnt > 0) begin
                        mem_we <= 1;
                        mem_waddr <= data_cnt[8:0] - 1;
                        mem_wdata <= spi_rx_data;
                    end
                    if (data_cnt == 512) state <= S_READ_CRC1;
                    else begin
                        data_cnt <= data_cnt + 1;
                        state <= S_SPI_START;
                    end
                end
                
                S_READ_CRC1: begin
                    spi_tx_data <= 8'hFF;
                    return_state <= S_READ_CRC2;
                    state <= S_SPI_START;
                end
                S_READ_CRC2: begin
                    spi_tx_data <= 8'hFF;
                    return_state <= S_DESELECT;
                    state <= S_SPI_START;
                end
                
                S_DESELECT: begin
                    sd_cs_n <= 1;
                    spi_tx_data <= 8'hFF;
                    return_state <= S_DONE;
                    state <= S_SPI_START;
                end
                
                S_DONE: begin
                    busy <= 0; state <= S_IDLE;
                end
                
                S_ERROR: begin
                    sd_cs_n <= 1; err <= 1; busy <= 0;
                    reinit_req <= 1;
                    state <= S_IDLE;
                end
                
                S_SPI_START: begin
                    spi_start <= 1;
                    state <= S_SPI_WAIT_BUSY;
                end
                S_SPI_WAIT_BUSY: begin
                    spi_start <= 0;
                    if (spi_busy) state <= S_SPI_WAIT;
                end
                S_SPI_WAIT: if (!spi_busy) state <= return_state;
            endcase
        end
    end
endmodule


module sd_hw_init (
    input  logic clk, rst,
    
    output logic spi_start,
    output logic [7:0] spi_tx_data,
    input  logic [7:0] spi_rx_data,
    input  logic spi_busy,
    
    output logic init_done, init_err,
    output logic sd_cs_n, spi_slow_clk
);
    typedef enum logic [4:0] {
        S_RESET, S_DELAY_LOOP, S_WAKEUP, S_WAKEUP_EXEC,
        S_SETUP_CMD0, S_SETUP_CMD8, S_FLUSH_CMD8,
        S_SETUP_CMD55, S_CHECK_CMD55, S_SETUP_ACMD41, S_DELAY_1MS,
        S_SEND_CMD, S_WAIT_R1, S_PROCESS_R1, S_DESELECT,
        S_CHECK_CMD0, S_CHECK_CMD8, S_CHECK_ACMD41,
        S_DONE, S_ERROR, S_ERROR_WAIT,
        S_SPI_START, S_SPI_WAIT_BUSY, S_SPI_WAIT
    } state_t;
    
    state_t state, return_state, r1_state;
    logic [7:0] cmd_buf [0:6];
    logic [2:0] byte_idx;
    logic [7:0] r1_val, retry_cnt;
    logic [25:0] wait_cnt;
    logic [15:0] acmd_retries;

    always_ff @(posedge clk) begin
        if (rst) begin
            state <= S_RESET;
            init_done <= 0; init_err <= 0; 
            sd_cs_n <= 1; spi_slow_clk <= 1; spi_start <= 0;
        end else begin
            case (state)
                S_RESET: begin
                    init_done <= 0; init_err <= 0; 
                    sd_cs_n <= 1; spi_slow_clk <= 1;
                    wait_cnt <= 26'd2_500_000;
                    acmd_retries <= 1000;
                    return_state <= S_WAKEUP;
                    state <= S_DELAY_LOOP;
                end
                
                S_DELAY_LOOP: begin
                    if (wait_cnt == 0) state <= return_state;
                    else wait_cnt <= wait_cnt - 1;
                end
                
                S_WAKEUP: begin
                    wait_cnt <= 10;
                    state <= S_WAKEUP_EXEC;
                end
                
                S_WAKEUP_EXEC: begin
                    if (wait_cnt == 0) state <= S_SETUP_CMD0;
                    else begin
                        sd_cs_n <= 1; spi_tx_data <= 8'hFF;
                        return_state <= S_WAKEUP_EXEC;
                        wait_cnt <= wait_cnt - 1;
                        state <= S_SPI_START;
                    end
                end
                
                S_SETUP_CMD0: begin
                    sd_cs_n <= 0; cmd_buf[0]<=8'hFF; cmd_buf[1]<=8'h40; cmd_buf[2]<=8'h00; cmd_buf[3]<=8'h00; 
                    cmd_buf[4]<=8'h00; cmd_buf[5]<=8'h00; cmd_buf[6]<=8'h95; byte_idx <= 0;
                    r1_state <= S_CHECK_CMD0; state <= S_SEND_CMD;
                end
                S_CHECK_CMD0: begin
                    if (r1_val == 8'h01) begin
                        return_state <= S_SETUP_CMD8;
                        state <= S_DESELECT;
                    end
                    else state <= S_ERROR;
                end
                
                S_SETUP_CMD8: begin
                    sd_cs_n <= 0; cmd_buf[0]<=8'hFF; cmd_buf[1]<=8'h48; cmd_buf[2]<=8'h00; cmd_buf[3]<=8'h00; 
                    cmd_buf[4]<=8'h01; cmd_buf[5]<=8'hAA; cmd_buf[6]<=8'h87; byte_idx <= 0;
                    r1_state <= S_CHECK_CMD8; state <= S_SEND_CMD;
                end
                S_CHECK_CMD8: begin
                    if (r1_val == 8'h01) wait_cnt <= 4; else wait_cnt <= 10;
                    state <= S_FLUSH_CMD8;
                end
                S_FLUSH_CMD8: begin
                    if (wait_cnt == 0) begin
                        return_state <= S_SETUP_CMD55;
                        state <= S_DESELECT;
                    end
                    else begin
                        spi_tx_data <= 8'hFF;
                        return_state <= S_FLUSH_CMD8;
                        wait_cnt <= wait_cnt - 1;
                        state <= S_SPI_START;
                    end
                end
                
                S_SETUP_CMD55: begin
                    sd_cs_n <= 0; cmd_buf[0]<=8'hFF; cmd_buf[1]<=8'h77; cmd_buf[2]<=8'h00; cmd_buf[3]<=8'h00; 
                    cmd_buf[4]<=8'h00; cmd_buf[5]<=8'h00; cmd_buf[6]<=8'h65; byte_idx <= 0;
                    r1_state <= S_CHECK_CMD55; state <= S_SEND_CMD;
                end
                S_CHECK_CMD55: begin
                    return_state <= S_SETUP_ACMD41;
                    state <= S_DESELECT;
                end
                
                S_SETUP_ACMD41: begin
                    sd_cs_n <= 0; cmd_buf[0]<=8'hFF; cmd_buf[1]<=8'h69; cmd_buf[2]<=8'h40; cmd_buf[3]<=8'h00; 
                    cmd_buf[4]<=8'h00; cmd_buf[5]<=8'h00; cmd_buf[6]<=8'h77; byte_idx <= 0;
                    r1_state <= S_CHECK_ACMD41; state <= S_SEND_CMD;
                end
                S_CHECK_ACMD41: begin
                    if (r1_val == 8'h00) begin
                        return_state <= S_DONE;
                        state <= S_DESELECT;
                    end
                    else begin
                        if (acmd_retries == 0) state <= S_ERROR;
                        else begin
                            acmd_retries <= acmd_retries - 1;
                            return_state <= S_DELAY_1MS;
                            state <= S_DESELECT;
                        end
                    end
                end
                
                S_DELAY_1MS: begin
                    wait_cnt <= 50_000;
                    return_state <= S_SETUP_CMD55;
                    state <= S_DELAY_LOOP;
                end
                
                S_DONE: begin
                    init_done <= 1;
                    spi_slow_clk <= 0;
                end
                
                S_ERROR: begin
                    init_err <= 1; init_done <= 1;
                    wait_cnt <= 50_000_000;
                    state <= S_ERROR_WAIT;
                end
                S_ERROR_WAIT: begin
                    if (wait_cnt == 0) state <= S_RESET;
                    else wait_cnt <= wait_cnt - 1;
                end
                
                S_SEND_CMD: begin
                    if (byte_idx == 7) begin
                        retry_cnt <= 100;
                        state <= S_WAIT_R1;
                    end
                    else begin
                        spi_tx_data <= cmd_buf[byte_idx];
                        return_state <= S_SEND_CMD; byte_idx <= byte_idx + 1;
                        state <= S_SPI_START;
                    end
                end
                S_WAIT_R1: begin
                    spi_tx_data <= 8'hFF;
                    return_state <= S_PROCESS_R1;
                    state <= S_SPI_START;
                end
                S_PROCESS_R1: begin
                    if (spi_rx_data[7] == 1'b0) begin
                        r1_val <= spi_rx_data; state <= r1_state; end
                    else begin
                        if (retry_cnt == 0) state <= S_ERROR;
                        else begin
                            retry_cnt <= retry_cnt - 1; state <= S_WAIT_R1;
                        end
                    end
                end
                S_DESELECT: begin
                    sd_cs_n <= 1;
                    spi_tx_data <= 8'hFF;
                    state <= S_SPI_START;
                end
                
                S_SPI_START: begin
                    spi_start <= 1;
                    state <= S_SPI_WAIT_BUSY;
                end
                S_SPI_WAIT_BUSY: begin
                    spi_start <= 0;
                    if (spi_busy) state <= S_SPI_WAIT;
                end
                S_SPI_WAIT: if (!spi_busy) state <= return_state;
            endcase
        end
    end
endmodule


module spi_master #(
    parameter input_clock_speed = 50_000_000,
    parameter slow_clk_frequency = 400_000,
    parameter fast_clk_frequency = 15_000_000
) (
    input  logic clk, rst, slow_clk, start,
    input  logic [7:0] tx_data,
    output logic [7:0] rx_data,
    output logic busy, sclk, mosi,
    input  logic miso
);
    localparam int SLOW_HALF_PERIOD = input_clock_speed / (slow_clk_frequency * 2);
    localparam int FAST_HALF_PERIOD = input_clock_speed / (fast_clk_frequency * 2);

    logic [15:0] tick_cnt, current_half_period; 
    logic [2:0]  bit_cnt;
    logic [7:0]  shift_reg_tx, shift_reg_rx;
    typedef enum logic [1:0] {IDLE, PHASE_LOW, PHASE_HIGH} state_t;
    state_t state;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            busy <= 0;
            sclk <= 0;
            mosi <= 1;
            rx_data <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    sclk <= 0; busy <= 0;
                    if (start) begin
                        busy <= 1; current_half_period <= slow_clk ? SLOW_HALF_PERIOD[15:0] : FAST_HALF_PERIOD[15:0];
                        shift_reg_tx <= tx_data; bit_cnt <= 7; tick_cnt <= 0; mosi <= tx_data[7]; state <= PHASE_LOW;
                    end
                end
                PHASE_LOW: begin
                    if (tick_cnt >= current_half_period - 1) begin
                        tick_cnt <= 0; sclk <= 1; shift_reg_rx[bit_cnt] <= miso; state <= PHASE_HIGH;
                    end else tick_cnt <= tick_cnt + 1;
                end
                PHASE_HIGH: begin
                    if (tick_cnt >= current_half_period - 1) begin
                        tick_cnt <= 0; sclk <= 0;
                        if (bit_cnt == 0) begin
                            rx_data <= shift_reg_rx;
                            state <= IDLE;
                        end 
                        else begin
                            bit_cnt <= bit_cnt - 1;
                            mosi <= shift_reg_tx[bit_cnt - 1];
                            state <= PHASE_LOW;
                        end
                    end else tick_cnt <= tick_cnt + 1;
                end
            endcase
        end
    end
endmodule