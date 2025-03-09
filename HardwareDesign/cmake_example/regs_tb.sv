module regs_tb ();

  logic clk, reset, regwrite;
  logic [4:0] rs1adr, rs2adr, rdadr;
  logic [31:0] rs1, rs2, rd;
  logic [31:0] rs1_assert, rs2_assert;

  regs dut (
      .clk(clk),
      .reset(reset),
      .regwrite(regwrite),
      .rs1adr(rs1adr),
      .rs2adr(rs2adr),
      .rdadr(rdadr),
      .rd(rd),
      .rs1(rs1),
      .rs2(rs2)
  );

  logic [112:0] tests[$];
  logic [112:0] test;

  assign reset = test[112];
  assign regwrite = test[111];
  assign rs1adr = test[110:106];
  assign rs2adr = test[105:101];
  assign rdadr = test[100:96];
  assign rd = test[95:64];
  assign rs1_assert = test[63:32];
  assign rs2_assert = test[31:0];

  always begin
    clk = 0;
    forever #1 clk = ~clk;
  end

  int test_index = 1;
  initial begin
    $dumpfile("regs_tb.vcd");
    $dumpvars(0, dut, test, rs1_assert, rs2_assert);

    // Add test cases
    //               rst   regw    rs1a       rs2a      rda          rd           rs1             rs2
    tests.push_back({1'b1, 1'b0, 5'b00000, 5'b00000, 5'b00000, 32'h00000000, 32'h00000000, 32'h00000000});  // reset
    tests.push_back({1'b0, 1'b0, 5'b00000, 5'b00000, 5'b00000, 32'h00000000, 32'h00000000, 32'h00000000});  // reading x0
    tests.push_back({1'b0, 1'b1, 5'b00000, 5'b00000, 5'b00001, 32'hABCD1234, 32'h00000000, 32'h00000000});  // writing x1
    tests.push_back({1'b0, 1'b0, 5'b00001, 5'b00001, 5'b00010, 32'hDEADBEEF, 32'hABCD1234, 32'hABCD1234});  // reading x1
    tests.push_back({1'b0, 1'b1, 5'b00001, 5'b00001, 5'b00010, 32'hDEADBEEF, 32'hABCD1234, 32'hABCD1234});  // writing x2
    tests.push_back({1'b0, 1'b0, 5'b00001, 5'b00001, 5'b00010, 32'hDEADBEEF, 32'hABCD1234, 32'hABCD1234});  // reading x1
    tests.push_back({1'b0, 1'b0, 5'b00010, 5'b00010, 5'b00010, 32'h00000000, 32'hDEADBEEF, 32'hDEADBEEF});  // reading x2
    tests.push_back({1'b0, 1'b1, 5'b00010, 5'b00010, 5'b00010, 32'h00110011, 32'hDEADBEEF, 32'hDEADBEEF});  // writing x2
    tests.push_back({1'b0, 1'b0, 5'b00001, 5'b00010, 5'b01010, 32'h00110011, 32'hABCD1234, 32'h00110011});  // reading x1, x2
    tests.push_back({1'b0, 1'b1, 5'b00001, 5'b00010, 5'b00000, 32'hFFFFFFFF, 32'hABCD1234, 32'h00110011});  // overriding x0
    tests.push_back({1'b0, 1'b0, 5'b00000, 5'b00000, 5'b00000, 32'hFFFFFFFF, 32'h00000000, 32'h00000000});  // testing x0
    tests.push_back({1'b0, 1'b0, 5'b00000, 5'b00000, 5'b00001, 32'hDEADBEEF, 32'h00000000, 32'h00000000});  // writing with no regw
    tests.push_back({1'b0, 1'b0, 5'b00001, 5'b00000, 5'b00000, 32'h00000000, 32'hABCD1234, 32'h00000000});  // checking previous write

    // Testing that every register exists:
    tests.push_back({1'b0, 1'b0, 5'b00000, 5'b00000, 5'b00000, 32'h00000000, 32'h00000000, 32'h00000000});  // reading x0
    for (int i=0; i < 32; i++) begin
        tests.push_back({1'b0, 1'b1, 5'b00000, 5'b00000, 5'(i), 32'(i), 32'h00000000, 32'h00000000});  // writing xi
    end

    for (int i=0; i < 32; i++) begin
        tests.push_back({1'b0, 1'b0, 5'(i), 5'(i), 5'b00000, 32'h00000000, 32'(i), 32'(i)});  // reading xi
    end

    // Test all cases and report errors
    while (tests.size > 0) begin
      test = tests.pop_front();
      #2;
      assert (rs1_assert == rs1)
      else
        $error(
            "Test %d: Wrong result for rs1: reset = %b, regwrite = %b, rs1adr = %h. Expected rs1 = %h but was %h",
            test_index,
            reset,
            regwrite,
            rs1adr,
            rs1_assert,
            rs1
        );
      assert (rs2_assert == rs2)
      else
        $error(
            "Test %d: Wrong result for rs2: reset = %b, regwrite = %b, rs2adr = %h. Expected rs2 = %h but was %h",
            test_index,
            reset,
            regwrite,
            rs2adr,
            rs2_assert,
            rs2
        );

      test_index = test_index + 1;
    end
    $finish;
  end

endmodule  // regs_tb
