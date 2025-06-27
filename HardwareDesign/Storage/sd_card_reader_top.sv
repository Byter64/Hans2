module top_ulx3s_sd_mem (
    input  logic        clk_25mhz,
    output logic        sd_clk,
    output logic        sd_cmd,
    inout  logic [3:0]  sd_d,
    output logic [7:0]  led
);
  // Clock generation
  logic rst = 1;
  logic [3:0] clkall;
  logic clk;

  ecp5pll #(
    .in_hz   (25000000),
    .out0_hz (50000000)
  ) pll (
    .clk_i(clk_25mhz),
    .clk_o(clkall)
  );

  assign clk = clkall[0];

  // SD IO setup
  assign sd_d[1] = 1'b1; // DAT1 pulled up
  assign sd_d[2] = 1'b1; // DAT2 pulled up

  logic sd_cs, sd_mosi;
  logic sd_miso;
  `ifdef SYNTHESIS
    assign sd_miso = sd_d[0];
  `else
    assign sd_miso = 0;
  `endif

  assign sd_d[3] = sd_cs;
  assign sd_cmd  = sd_mosi;

  // AXI-Lite signals
  logic [31:0] awaddr, wdata, araddr;
  logic [2:0]  awprot, arprot;
  logic [3:0]  wstrb;
  logic        awvalid, wvalid, bready, arvalid, rready;
  logic        awready, wready, bvalid, rvalid, arready;
  logic [1:0]  bresp, rresp;
  logic [31:0] rdata;

  // FSM states
  typedef enum logic [3:0] {
    IDLE,
    WRITE_INIT,
    WRITE_WORD,
    WAIT_WRITE,
    READ_INIT_0,
    WAIT_READ_0,
    READ_INIT_1,
    WAIT_READ_1,
    WRITE_COPY_0,
    WAIT_COPY_0,
    WRITE_COPY_1,
    WAIT_COPY_1,
    DONE
  } state_t;

  state_t state = IDLE;
  logic[7:0] word_idx = 0;
  integer copy_idx = 1;
  logic [31:0] read_buffer;

  // AXI write logic
  assign awprot = 3'b000;
  assign wstrb  = 4'b1111;
  assign bready = 1;

  // AXI read logic
  assign arprot = 3'b000;
  assign rready = (state == WAIT_READ_0 || state == WAIT_READ_1);

always_ff @(posedge clk) begin
  if (rst) begin
    state      <= WRITE_INIT;
    rst        <= 0;
    awvalid    <= 0;
    wvalid     <= 0;
    arvalid    <= 0;
    word_idx   <= 0;
    copy_idx   <= 1;
    led        <= 1;
  end else begin
    case (state)
      WRITE_INIT: begin
        awaddr  <= word_idx * 4;
        wdata   <= {16'hFFFF, word_idx, 8'hFF};
        awvalid <= 1;
        wvalid  <= 1;
        state   <= WRITE_WORD;
        led     <= 2;
      end

      WRITE_WORD: begin
        if (awready) awvalid <= 0;
        if (wready) begin
          wvalid <= 0;
          state  <= WAIT_WRITE;
        end
      end

      WAIT_WRITE: begin
        if (bvalid) begin
          if (word_idx < 127) begin
            word_idx <= word_idx + 1;
            state    <= WRITE_INIT;
          end else begin
            word_idx <= 0;
            state    <= READ_INIT_0;
          end
        end
      end

      // Read from sector 0
      READ_INIT_0: begin
        araddr  <= copy_idx * 4; // sector 0 offset N
        arvalid <= 1;
        state   <= WAIT_READ_0;
        led     <= 3;
      end

      WAIT_READ_0: begin
        if (arready) arvalid <= 0;
        if (rvalid) begin
          read_buffer <= rdata;
          state <= READ_INIT_1;
          led   <= 4;
        end
      end

      // Read from sector (copy_idx - 1)
      READ_INIT_1: begin
        araddr  <= (copy_idx - 1) * 512; // word 0 of sector before
        arvalid <= 1;
        state   <= WAIT_READ_1;
        led     <= 5;
      end

      WAIT_READ_1: begin
        if (arready) arvalid <= 0;
        if (rvalid) begin
          // Store both read results in a temp buffer
          awaddr  <= copy_idx * 512; // offset 0 of current sector
          wdata   <= read_buffer;
          awvalid <= 1;
          wvalid  <= 1;
          state   <= WAIT_COPY_0;
          led     <= 6;
        end
      end

      WAIT_COPY_0: begin
        if (awready) awvalid <= 0;
        if (wready)  wvalid  <= 0;
        if (bvalid) begin
          awaddr  <= copy_idx * 512 + 4; // offset 1
          wdata   <= rdata;
          awvalid <= 1;
          wvalid  <= 1;
          state   <= WAIT_COPY_1;
          led     <= 7;
        end
      end

      WAIT_COPY_1: begin
        if (awready) awvalid <= 0;
        if (wready)  wvalid  <= 0;
        if (bvalid) begin
          if (copy_idx < 10) begin
            copy_idx <= copy_idx + 1;
            state    <= READ_INIT_0;
          end else begin
            state <= DONE;
          end
        end
      end

      DONE: begin
        led <= 8'hFF;
      end

      default: state <= DONE;
    endcase
  end
end


  // AXI-Lite SD card controller instantiation
  sd_card_reader sd_inst (
    .aclk             (clk),
    .aresetn          (~rst),

    .s_axil_awaddr    (awaddr),
    .s_axil_awprot    (awprot),
    .s_axil_awvalid   (awvalid),
    .s_axil_awready   (awready),

    .s_axil_wdata     (wdata),
    .s_axil_wstrb     (wstrb),
    .s_axil_wvalid    (wvalid),
    .s_axil_wready    (wready),

    .s_axil_bresp     (bresp),
    .s_axil_bvalid    (bvalid),
    .s_axil_bready    (bready),

    .s_axil_araddr    (araddr),
    .s_axil_arprot    (arprot),
    .s_axil_arvalid   (arvalid),
    .s_axil_arready   (arready),

    .s_axil_rdata     (rdata),
    .s_axil_rresp     (rresp),
    .s_axil_rvalid    (rvalid),
    .s_axil_rready    (rready),

    .miso             (sd_miso),
    .sclk             (sd_clk),
    .cs               (sd_cs),
    .mosi             (sd_mosi)
  );

endmodule
