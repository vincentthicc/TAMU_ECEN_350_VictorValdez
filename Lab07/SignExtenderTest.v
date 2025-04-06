`timescale 1ns / 1ps
`define STRLEN 32

module SignExtenderTest_v;

  // A simple self-checking “pass/fail” task
  task passTest;
	input [63:0] actualOut;  	// SignExtender output
	input [63:0] expectedOut;	// Expected result
	input [`STRLEN*8:0] testName; // A string for logging
	inout [7:0] passed;      	// Reference to pass counter

	if (actualOut == expectedOut) begin
  	$display("%s passed", testName);
  	passed = passed + 1;
	end else begin
  	$display("%s failed: got 0x%h but expected 0x%h",
           	testName, actualOut, expectedOut);
	end
  endtask

  // Display a final summary of how many tests passed
  task allPassed;
	input [7:0] passed;
	input [7:0] numTests;
	if (passed == numTests)
  	$display("All tests passed");
	else
  	$display("Some tests failed (%0d of %0d).", (numTests - passed), numTests);
  endtask

  reg [25:0] Imm;   // 26-bit immediate field
  reg [1:0]  Ctrl;  // Control to select which extension
  wire [63:0] ExtImm;

  // A counter for how many tests pass
  reg [7:0] passed;

  SignExtender uut (
	.ExtImm(ExtImm),
	.Imm(Imm),
	.Ctrl(Ctrl)
  );


	initial begin
		passed = 0;

		$dumpfile("SignExtenderTest_v.vcd");
		$dumpvars(0, SignExtenderTest_v);

	      //============ Tests ============

	      // I-type:
	      {Imm, Ctrl} = {26'b0000_011101110110_0000000000, 2'b00}; #40;
	      passTest(ExtImm, 64'h0000000000000776, "I-type (0x0000000000000776 & b00)", passed);

	      // D-type:
	      {Imm, Ctrl} = {26'b00000_110110101_000000000000, 2'b01}; #40;
	      passTest(ExtImm, 64'hFFFFFFFFFFFFFFB5, "D-type (0xFFFFFFFFFFFFFFB5 & b01)", passed);

	      // B-type:
	      {Imm, Ctrl} = {26'b00101101001010101011101001, 2'b10}; #40;
	      passTest(ExtImm, 64'h0000000000B4AAE9, "B-type (0x0000000000B4AAE9 & b10)", passed);

	      // CB-type:
	      {Imm, Ctrl} = {26'b00_1011010110100100001_00000, 2'b11}; #40;
	      passTest(ExtImm, 64'hFFFFFFFFFFFDAD21, "CB-type (0xFFFFFFFFFFFDAD21 & b11)", passed);


	      allPassed(passed, 4);
	end
      
endmodule

