module top_ulx3s_sd_mem (
    input  logic        clk_25mhz,
    output logic        sd_clk,
    output logic        sd_cmd,
    inout  logic [3:0]  sd_d,
    output logic [7:0] led
);
  // Clock and reset
  logic rst = 1;
  logic[3:0] clkall;
  logic clk;
  ecp5pll #(
    .in_hz       (25000000),
    .out0_hz     (50000000)
  ) uut (
    .clk_i(clk_25mhz),
    .clk_o(clkall)
  );
  assign clk = clkall[0];


  // Tie SD lines
  assign sd_d[1] = 1'b1; // DAT1 must be held HIGH
  assign sd_d[2] = 1'b1; // DAT2 must be held HIGH

  // SD lines
  logic sd_cs, sd_mosi;

  logic sd_miso;
  `ifdef SYNTHESIS assign sd_miso = sd_d[0];
  `else assign sd_miso = 0;
  `endif
  assign sd_d[3] = sd_cs;  // DAT3 = Chip Select (CS)
  assign sd_cmd = sd_mosi; // CMD (MOSI)

  // AXI-Lite interface
  logic [31:0] awaddr, wdata, araddr;
  logic [2:0]  awprot, arprot;
  logic [3:0]  wstrb;
  logic        awvalid, wvalid, bready, arvalid, rready;
  logic        awready, wready, bvalid, rvalid;
  logic [1:0]  bresp, rresp;
  logic [31:0] rdata;

  // FSM to write to SD card
  typedef enum logic [3:0] {
    IDLE,
    WRITE,
    WAIT_WRITE_DONE,
    DONE
  } state_t;

  state_t state = IDLE;
  integer sector = 0;
  reg [31:0] word_idx = 0;

  always_ff @(posedge clk) begin
    if (rst) begin
      state    <= IDLE;
      awvalid  <= 0;
      wvalid   <= 0;
      bready   <= 1;
      awaddr   <= 0;
      wdata    <= 0;
      wstrb    <= 4'b1111;
      word_idx <= 0;
      sector   <= 0;
      rst      <= 0; // release reset after first cycle
      led      <= 1;
    end else begin
      case (state)
        IDLE: begin
          // Start writing to first sector
          awaddr  <= sector * 512 + word_idx * 4;
          wdata   <= word_idx + 32'h34120000;
          awvalid <= 1;
          wvalid  <= 1;
          state   <= WRITE;
          led      <= 2;
        end

        WRITE: begin
          if(awready)begin
            awvalid <= 0;
          end
          if(wready)begin
            wvalid <= 0;
            state   <= WAIT_WRITE_DONE;
          end
          led      <= 4;
        end

        WAIT_WRITE_DONE: begin
          if (bvalid) begin
            if (word_idx < 128) begin
              word_idx <= word_idx + 1;
              state    <= IDLE;
            end else if (sector < 3) begin
              word_idx <= 0;
              sector   <= sector + 1;
              state    <= IDLE;
            end else begin
              state <= DONE;
            end
          end
          led      <= 8;
        end

        DONE: begin
          // Do nothing
          led      <= 15;
        end
      endcase
    end
  end

  // AXI-Lite slave instantiation
  sd_card_reader sd_inst (
    .aclk             (clk),
    .aresetn          (~rst),
    .s_axil_awaddr    (awaddr),
    .s_axil_awprot    (3'b000),
    .s_axil_awvalid   (awvalid),
    .s_axil_awready   (awready),
    .s_axil_wdata     (wdata),
    .s_axil_wstrb     (wstrb),
    .s_axil_wvalid    (wvalid),
    .s_axil_wready    (wready),
    .s_axil_bresp     (bresp),
    .s_axil_bvalid    (bvalid),
    .s_axil_bready    (bready),
    .s_axil_araddr    (32'b0),
    .s_axil_arprot    (3'b000),
    .s_axil_arvalid   (1'b0),
    .s_axil_arready   (),
    .s_axil_rdata     (),
    .s_axil_rresp     (),
    .s_axil_rvalid    (),
    .s_axil_rready    (1'b0),
    .miso             (sd_miso),
    .sclk             (sd_clk),
    .cs               (sd_cs),
    .mosi             (sd_mosi)
  );

endmodule
