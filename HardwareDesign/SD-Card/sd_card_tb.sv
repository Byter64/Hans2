module tb_sd_card_reader;

  logic        aclk;
  logic        aresetn;

  // AXI Lite write address channel
  logic [31:0] s_axil_awaddr;
  logic [2:0]  s_axil_awprot;
  logic        s_axil_awvalid;
  logic        s_axil_awready;

  // AXI Lite write data channel
  logic [31:0] s_axil_wdata;
  logic [3:0]  s_axil_wstrb;
  logic        s_axil_wvalid;
  logic        s_axil_wready;

  // AXI Lite write response channel
  logic [1:0]  s_axil_bresp;
  logic        s_axil_bvalid;
  logic        s_axil_bready;

  // AXI Lite read address channel
  logic [31:0] s_axil_araddr;
  logic [2:0]  s_axil_arprot;
  logic        s_axil_arvalid;
  logic        s_axil_arready;

  // AXI Lite read data channel
  logic [31:0] s_axil_rdata;
  logic [1:0]  s_axil_rresp;
  logic        s_axil_rvalid;
  logic        s_axil_rready;

  // Dummy SD interface
  logic miso;
  logic sclk;
  logic cs;
  logic mosi;

  // Instantiate DUT
  sd_card_reader dut (
    .aclk           (aclk),
    .aresetn        (aresetn),
    .s_axil_awaddr  (s_axil_awaddr),
    .s_axil_awprot  (s_axil_awprot),
    .s_axil_awvalid (s_axil_awvalid),
    .s_axil_awready (s_axil_awready),
    .s_axil_wdata   (s_axil_wdata),
    .s_axil_wstrb   (s_axil_wstrb),
    .s_axil_wvalid  (s_axil_wvalid),
    .s_axil_wready  (s_axil_wready),
    .s_axil_bresp   (s_axil_bresp),
    .s_axil_bvalid  (s_axil_bvalid),
    .s_axil_bready  (s_axil_bready),
    .s_axil_araddr  (s_axil_araddr),
    .s_axil_arprot  (s_axil_arprot),
    .s_axil_arvalid (s_axil_arvalid),
    .s_axil_arready (s_axil_arready),
    .s_axil_rdata   (s_axil_rdata),
    .s_axil_rresp   (s_axil_rresp),
    .s_axil_rvalid  (s_axil_rvalid),
    .s_axil_rready  (s_axil_rready),
    .miso           (miso),
    .sclk           (sclk),
    .cs             (cs),
    .mosi           (mosi)
  );

  // Clock generation
  initial aclk = 0;
  always #5 aclk = ~aclk;

  // Task to write to AXI Lite
  task axi_write(input [31:0] addr, input [31:0] data);
    begin
      @(posedge aclk);
      s_axil_awaddr  <= addr;
      s_axil_awprot  <= 3'b000;
      s_axil_awvalid <= 1;
      s_axil_wdata   <= data;
      s_axil_wstrb   <= 4'b1111;
      s_axil_wvalid  <= 1;

      // Wait for AWREADY and WREADY
      wait (s_axil_awready && s_axil_wready);
      @(posedge aclk);
      s_axil_awvalid <= 0;
      s_axil_wvalid  <= 0;

      // Wait for BVALID
      s_axil_bready <= 1;
      wait (s_axil_bvalid);
      @(posedge aclk);
      s_axil_bready <= 0;
    end
  endtask

  // Task to read from AXI Lite
  task axi_read(input [31:0] addrr, output [31:0] data_out);
    begin
      @(posedge aclk);
      s_axil_araddr  <= addrr;
      s_axil_arprot  <= 3'b000;
      s_axil_arvalid <= 1;

      wait (s_axil_arready);
      @(posedge aclk);
      s_axil_arvalid <= 0;

      s_axil_rready <= 1;
      wait (s_axil_rvalid);
      data_out = s_axil_rdata;
      @(posedge aclk);
      s_axil_rready <= 0;
    end
  endtask
  logic j = 0;
  // Test sequence
  initial begin
    // Initialize signals
    s_axil_awvalid = 0;
    s_axil_wvalid  = 0;
    s_axil_bready  = 0;
    s_axil_arvalid = 0;
    s_axil_rready  = 0;
    aresetn = 0;
    miso = 0;

    #20;
    aresetn = 1;
    #20;

    // Write and read loop
    for (int i = 0; i < 2048; i += 4) begin
      axi_write(i, 32'hABCD0000 + i);
    end

    $display("finished writedata");
    for (int i = 0; i < 2048; i += 4) begin
      logic [31:0] rdata;
      axi_read(i, rdata);
      if (rdata !== (32'hABCD0000  + i)) begin
        $display("ERROR: Read mismatch at address %d. Got %h, should %h", i, rdata, 32'hABCD0000  + i);
      end
    end

    $display("All AXI-Lite transactions succeeded.");
    $finish;
  end
    integer idx;

  initial begin
    $dumpfile("dump.vcd");

    $dumpvars(0,tb_sd_card_reader);
    for (idx = 0; idx < 128; idx++) begin
      $dumpvars(0,tb_sd_card_reader.dut.ram[idx]); 
    end
    for (idx = 0; idx < 2048; idx++) begin
      $dumpvars(0,tb_sd_card_reader.dut.sd1.ram[idx]); 
    end
    #2400000;
    $finish;
  end
endmodule
