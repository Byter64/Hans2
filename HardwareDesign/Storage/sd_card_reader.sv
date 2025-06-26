module sd_card_reader #(
    parameter OFFSET = 0
) (
    input aclk,
    input aresetn,
    /*
    * AXI lite slave interfaces
    */
    input logic [31:0] s_axil_awaddr,
    input logic [2:0] s_axil_awprot,
    input logic s_axil_awvalid,
    output logic s_axil_awready,

    input logic [31:0] s_axil_wdata,
    input logic [3:0] s_axil_wstrb,
    input logic s_axil_wvalid,
    output logic s_axil_wready,

    output logic [1:0] s_axil_bresp,
    output logic s_axil_bvalid,
    input logic s_axil_bready,

    input logic [31:0] s_axil_araddr,
    input logic [2:0] s_axil_arprot,
    input logic s_axil_arvalid,
    output logic s_axil_arready,

    output logic [31:0] s_axil_rdata,
    output logic [1:0] s_axil_rresp,
    output logic s_axil_rvalid,
    input logic s_axil_rready,

    //SD_controller
    input logic miso,    // Connect to SD_DAT[0].
    output logic sclk,   // Connect to SD_SCK.
    output logic cs,     // Connect to SD_DAT[3].
    output logic mosi    // Connect to SD_CMD.
    // For SPI mode, SD_DAT[2] and SD_DAT[1] should be held HIGH.
    // SD_RESET should be held LOW.
);
    // TODO AXI-L Read is one addr to low
    ///////////////////////////////////////////////////////////////////////
    // Reset signal
    logic rst;
    assign rst = ~aresetn;

    // Data needed to be written to and from from axi
    logic read_data;
    logic write_data;

    logic [31:0] data_addr;
    logic [31:0] data_in;
    logic [3:0] write_mask;

    logic [31:0] data_out;
    logic data_out_valid;
    logic busy;
    logic [31:0] data_addr_write = 0;
    logic [31:0] data_addr_read = 0;

    logic store_read_write_operation = 0; // Read = 1; Write = 0;
    
    // State machine definition
    typedef enum logic[5:0] {
        Initialize, //0
        Idle,       //1
        WaitSDCard, //2
        WriteSDCard,//3
        ReadSDCard, //4
        PerformOperation // 5
    } ControllerState;
    
    ControllerState state = Initialize;

    (* ram_style = "logic" *)
    logic [31:0] ram[0:127];

    logic [6:0] ram_waddr;
    logic [31:0] ram_wdata;
    logic ram_we;
    logic [3:0] ram_be;
    
    logic [6:0] ram_raddr;
    logic [31:0] ram_rdata;
    
    always @(posedge aclk) begin
        if (ram_we) begin
            if (ram_be[3]) ram[ram_waddr][31:24] <= ram_wdata[31:24];
            if (ram_be[2]) ram[ram_waddr][23:16] <= ram_wdata[23:16];
            if (ram_be[1]) ram[ram_waddr][15:8] <= ram_wdata[15:8];
            if (ram_be[0]) ram[ram_waddr][7:0] <= ram_wdata[7:0];
        end
    end
    
    always @(posedge aclk) begin
        ram_rdata <= ram[ram_raddr];
    end
    
    logic ram_dirty = '0;
    logic [22:0] tag;

    assign busy = state != Idle;

    // SD CARD INPUTS/OUTPUTS
    logic sd_card_read = 0;         // Read signal for SD card
    logic sd_card_write = 0;
    logic [7:0] sd_card_dout;       // data output for read operation
    logic [7:0] sd_card_din;        // data input for write operation
    logic sd_card_byte_available;   // byte can be read
    logic sd_card_ready_for_next_byte; // byte can be written
    logic sd_card_ready;
    logic [22:0] sd_card_sector_address;

    // SD CARD LOGIC
    logic [8:0] byte_counter = 0;

    /////////////////////AXI-LITE/////////////////////
    /////////////////// AW /////////////////////
    always_ff @(posedge aclk) begin
        // Logic to determine S_AXIS_AWREADY
        s_axil_awready <= (state == Idle);
    end

    always_ff @(posedge aclk) begin
        if (s_axil_awvalid && s_axil_awready) begin //Never add any other conditions. This is likely to break axi
            data_addr_write <= s_axil_awaddr - OFFSET;
        end
    end

    /////////////////// W ///////////////////// 
    always_ff @(posedge aclk) begin
        // Logic to determine S_AXIS_WREADY
        s_axil_wready <= (state == Idle) && ~read_data && ~write_data && !(s_axil_awready && s_axil_awvalid) && !s_axil_awvalid;
    end

  always_ff @(posedge aclk) begin
    write_data <= 0;
    if (s_axil_wvalid && s_axil_wready) begin //Never add any other conditions. This is likely to break axi
      data_in <= s_axil_wdata;
      write_data <= 1;
      write_mask <= s_axil_wstrb;
    end
  end

    /////////////////// AR /////////////////////
    always_ff @(posedge aclk) begin
        // Logic to determine S_AXIS_ARREADY
        s_axil_arready <= (state == Idle) && ~(s_axil_wvalid && s_axil_wready) && ~read_data && ~write_data;
    end

    always_ff @(posedge aclk) begin
        read_data <= 0;
        if (s_axil_arvalid && s_axil_arready) begin //Never add any other conditions. This is likely to break axi
            data_addr_read <= s_axil_araddr - OFFSET;
            read_data <= 1;
        end
    end

    /////////////////// B /////////////////////
    logic pending_write_answer = 0;
    logic next_bvalid; //Assign your valid logic to this signal
    logic[1:0] next_bresp; //Assign the data here
    assign next_bvalid = pending_write_answer && (state == Idle && ~write_data);
    assign next_bresp = 0;

    always_ff @(posedge aclk) begin
        if(s_axil_wready && s_axil_wvalid)
            pending_write_answer <= 1;
        if (s_axil_bready && s_axil_bvalid)
            pending_write_answer <= 0; 
    end
    
    always_ff @(posedge aclk) begin
        if (!aresetn)
            s_axil_bvalid <= 0;
        else if (!s_axil_bvalid || s_axil_bready) begin
            s_axil_bvalid <= (s_axil_bvalid && s_axil_bready) ? 0 : next_bvalid;
        end
    end

    always_ff @(posedge aclk) begin
        if (!aresetn)
            s_axil_bresp <= 0;
        else if (!s_axil_bvalid || s_axil_bready) begin
            s_axil_bresp <= next_bresp;

            if (!next_bvalid)
                s_axil_bresp <= 0;
        end
    end

    /////////////////// R /////////////////////
    logic next_rvalid; //Assign your valid logic to this signal
    logic[31:0] next_rData; //Assign the data here
    assign next_rvalid = data_out_valid;
    assign next_rData = ram_rdata;
    
    always_ff @(posedge aclk) begin
        if (!aresetn)
            s_axil_rvalid <= 0;
        else if (!s_axil_rvalid || s_axil_rready) begin
            s_axil_rvalid <= next_rvalid;
        end
    end

    always_ff @(posedge aclk) begin
        if (!aresetn)
            s_axil_rdata <= 0;
        else if (!s_axil_rvalid || s_axil_rready) begin
            s_axil_rdata <= next_rData;

            if (!next_rvalid)
                s_axil_rdata <= 0;
        end
    end
    ///////////////////AXI-LITE END///////////////////

    // CDC for control signals going to SD controller (aclk -> sdclk[1])
    localparam SD_CDC_DEPTH = 63;
    logic [SD_CDC_DEPTH-1:0] sd_card_read_cdc;
    logic [SD_CDC_DEPTH-1:0] sd_card_write_cdc;

    always @(posedge aclk) begin
        sd_card_read_cdc <= {sd_card_read_cdc[SD_CDC_DEPTH-2:0], sd_card_read};
        sd_card_write_cdc <= {sd_card_write_cdc[SD_CDC_DEPTH-2:0], sd_card_write};
    end

    sd_controller sd1 (
        .cs(cs),
        .mosi(mosi),
        .miso(miso),
        .sclk(sclk),
        .rd(|sd_card_read_cdc),
        .dout(sd_card_dout),
        .byte_available(sd_card_byte_available),
        .wr(|sd_card_write_cdc),
        .din(sd_card_din),
        .ready_for_next_byte(sd_card_ready_for_next_byte),
        .ready(sd_card_ready),
        .address({tag,9'b0}),
        .clk(aclk),
        .reset(rst)
    );

    logic old_sd_card_ready_for_next_byte;
    logic sd_card_ready_for_next_byte_strobe;
    assign sd_card_ready_for_next_byte_strobe = (~old_sd_card_ready_for_next_byte && sd_card_ready_for_next_byte);
    
    always_ff @(posedge aclk) begin
            old_sd_card_ready_for_next_byte <= sd_card_ready_for_next_byte;
    end

    logic old_sd_card_byte_available;
    logic sd_card_byte_available_strobe;
    assign sd_card_byte_available_strobe = (~old_sd_card_byte_available && sd_card_byte_available);
    
    always_ff @(posedge aclk) begin
            old_sd_card_byte_available <= sd_card_byte_available;
    end

    // BRAM read data registers
    logic [7:0] read_byte0;
    logic [7:0] read_byte1;
    logic [7:0] read_byte2;
    logic [7:0] read_byte3;
    
    // Main state machine
    always_ff @(posedge aclk) begin
        sd_card_write <= 0;
        sd_card_read <= 0;
        data_out_valid <= 0;
        ram_we <= 0; // Default value, will be set when needed
        ram_be <= 0; // Default all byte enables off
        if (!aresetn) begin
            state <= Initialize;
            ram_dirty <= 0;
        end else begin            
            case (state)
                Initialize: begin
                    if(sd_card_ready) begin
                        state <= ReadSDCard;
                        sd_card_sector_address <= '0;
                        ram_dirty <= 0;
                        sd_card_read <= 1;
                        byte_counter <= '0;
                    end
                end
                
                Idle: begin
                    // Hit
                    if((tag == data_addr_read[31:9] && read_data)) begin
                        // Read data from RAM - synchronous read using BRAM pattern
                        // Set read address for next cycle read (convert byte address to word address)
                        ram_raddr <= data_addr_read[8:2]; // Divide by 4 for word address
                        // Schedule output for next cycle when data is available
                        state <= PerformOperation;
                        store_read_write_operation <= 1;
                        //Write data to RAM, set dirty bit
                    end else if((tag == data_addr_write[31:9] && write_data)) begin
                        ram_dirty <= 1;
                        // Perform the write operation with byte enables
                        ram_we <= 1;
                        ram_waddr <= data_addr_write[8:2]; // Divide by 4 for word address
                        ram_wdata <= data_in;
                        ram_be <= write_mask; // Use write_mask directly as byte enables
                    end
                    // No Hit
                    else if(read_data || write_data) begin
                        state <= WaitSDCard;
                        data_addr <= read_data ? data_addr_read : data_addr_write;
                        store_read_write_operation <= read_data;
                    end
                end
                
                WaitSDCard: begin
                    sd_card_sector_address <= data_addr[31:9];
                    ram_raddr <= 0;
                    if(sd_card_ready) begin
                        // RAM dirty, Write into SD card, Read from SD Card
                        if(ram_dirty) begin
                            byte_counter <= '0;
                            state <= WriteSDCard;
                            sd_card_write <= '1;
                        end
                        // RAM not dirty, Read from SD Card
                        else begin
                            byte_counter <= '0;
                            state <= ReadSDCard;
                            sd_card_read <= '1;
                        end
                    end
                end
                
                WriteSDCard: begin
                    ram_dirty <= 0;
                    if(sd_card_ready_for_next_byte_strobe) begin
                        byte_counter <= byte_counter + 1;
                        
                        // Read from BRAM for SD card write
                        // Calculate which word and which byte within the word
                        
                        case(byte_counter[1:0])
                            2'b00: sd_card_din <= ram_rdata[7:0];
                            2'b01: sd_card_din <= ram_rdata[15:8];
                            2'b10: sd_card_din <= ram_rdata[23:16];
                            2'b11: begin
                                ram_raddr <= ram_raddr + 1;
                                sd_card_din <= ram_rdata[31:24];
                            end
                        endcase
                    end
                    if(&byte_counter) begin
                        byte_counter <= byte_counter;
                        if(sd_card_ready) begin
                            byte_counter <= '0;
                            state <= ReadSDCard;
                            sd_card_read <= '1;
                        end
                    end
                end
                
                ReadSDCard: begin
                    tag <= sd_card_sector_address;
                    if(sd_card_byte_available_strobe) begin
                        byte_counter <= byte_counter + 1;
                        
                        // Accumulate bytes until we have a full word to write
                        // Once we have all bytes for a word, write to BRAM
                        case(byte_counter[1:0])
                            2'b00: begin
                                ram_wdata[7:0] <= sd_card_dout;
                            end
                            2'b01: begin
                                ram_wdata[15:8] <= sd_card_dout;
                            end
                            2'b10: begin
                                ram_wdata[23:16] <= sd_card_dout;
                            end
                            2'b11: begin
                                ram_wdata[31:24] <= sd_card_dout;
                                ram_be <= 4'b1111;
                                ram_we <= 1;
                                ram_waddr <= byte_counter[8:2];
                            end
                        endcase
                    end
                    if(&byte_counter) begin
                        byte_counter <= byte_counter;
                        if(sd_card_ready) begin
                            // For read operation, set the read address
                            state <= PerformOperation;
                            if(store_read_write_operation) begin
                              ram_raddr <= data_addr[8:2]; // Divide by 4 for word address
                            end
                        end
                    end
                end
                
                PerformOperation: begin
                    if(store_read_write_operation) begin
                        // Data should be available in ram_rdata
                        data_out_valid <= 1;
                        state <= Idle;
                    end
                    //Write data to RAM, set dirty bit
                    else begin
                        ram_dirty <= 1;
                        // Perform the write operation with byte enables
                        ram_we <= 1;
                        ram_waddr <= data_addr[8:2]; // Divide by 4 for word address
                        ram_wdata <= data_in;
                        ram_be <= write_mask; // Use write_mask directly as byte enables
                        state <= Idle;
                    end
                end
                
                default: begin
                    state <= Initialize;
                end
            endcase
        end
    end
endmodule