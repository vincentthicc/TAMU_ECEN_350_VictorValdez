`timescale 1ns / 1ps
`define STRLEN 32

module NextPCLogic_v;

  // --------------------------------------
  // A simple self-checking “pass/fail” task
  // --------------------------------------
  task passTest;
	input [63:0] actualOut;   	// NextPC output
	input [63:0] expectedOut; 	// Expected result
	input [`STRLEN*8:0] testName; // A string for logging
	inout [7:0] passed;       	// Reference to pass counter

	if (actualOut == expectedOut) begin
  	$display("%s passed", testName);
  	passed = passed + 1;
	end else begin
  	$display("%s failed: got 0x%h but expected 0x%h",
           	testName, actualOut, expectedOut);
	end
  endtask

  // --------------------------------------
  // Display a final summary of how many tests passed
  // --------------------------------------
  task allPassed;
	input [7:0] passed;
	input [7:0] numTests;
	if (passed == numTests)
  	$display("All tests passed");
	else
  	$display("Some tests failed (%0d of %0d).", (numTests - passed), numTests);
  endtask

  // --------------------------------------
  // Inputs to the DUT
  // --------------------------------------
  reg  [63:0] CurrentPC, SignExtImm64;
  reg	Branch, ALUZero, UncondBranch;

  // Output from the DUT
  wire [63:0] NextPC;

  // A counter for how many tests pass
  reg [7:0] passed;

  // --------------------------------------
  // DUT Instantiation
  // --------------------------------------
  NextPCLogic uut (
	.CurrentPC	(CurrentPC),
	.SignExtImm64 (SignExtImm64),
	.Branch   	(Branch),
	.ALUZero  	(ALUZero),
	.Uncondbranch (UncondBranch),
	.NextPC   	(NextPC)
  );

  // --------------------------------------
  // Begin Test Stimulus
  // --------------------------------------
  initial begin
	passed = 0;

	$dumpfile("NextPCLogic_v.vcd");
	$dumpvars(0, NextPCLogic_v);

	// ---------------------------
	// TEST #1 - No branch
	// ---------------------------
	CurrentPC 	= 64'h0000000000000000;
	SignExtImm64  = 64'hFFFFFFFFFFFFFFFF; // irrelevant
	Branch    	= 0;
	ALUZero   	= 1;	// irrelevant
	UncondBranch  = 0;
	#20;  // Wait some time
	passTest(NextPC, 64'h4,
         	"Test 1: No branch => PC+4", passed);

	// ---------------------------
	// TEST #2 - Unconditional branch
	// ---------------------------
	CurrentPC 	= 64'h0;
	SignExtImm64  = 64'h3;  // 3 << 2 = 12
	Branch    	= 0;
	ALUZero   	= 0;  	// doesn't matter
	UncondBranch  = 1;
	#20;
	passTest(NextPC, 64'hC,
         	"Test 2: Unconditional branch => PC + (Imm<<2)", passed);

	// ---------------------------
	// TEST #3 - Conditional branch, ALUZero=1
	// ---------------------------
	CurrentPC 	= 64'h100;
	SignExtImm64  = 64'h1;   // 1 << 2 = 4
	Branch    	= 1;
	ALUZero   	= 1;
	UncondBranch  = 0;
	#20;
	passTest(NextPC, 64'h104,
         	"Test 3: Conditional branch => PC + (Imm<<2)", passed);

	// ---------------------------
	// Display final results
	// ---------------------------
	allPassed(passed, 3);
	$finish;
  end

endmodule



