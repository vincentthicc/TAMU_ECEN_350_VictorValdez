`timescale 1ns / 1ps
`define STRLEN 32

module RegisterFileTest_v;
	task passTest(
    	input [63:0]      	actualOut,
    	input [63:0]      	expectedOut,
    	input [`STRLEN*8:0]   testName,
    	inout [7:0]       	passed
	);
	begin
    	if (actualOut == expectedOut) begin
        	$display("%s passed", testName);
        	passed = passed + 1;
    	end else begin
        	$display("%s failed: got 0x%h, expected 0x%h",
                 	testName, actualOut, expectedOut);
    	end
	end
	endtask

	task allPassed(
    	input [7:0] passed,
    	input [7:0] numTests
	);
	begin
    	if(passed == numTests)
        	$display ("All tests passed");
    	else
        	$display("Some tests failed (%0d of %0d).",
                  	(numTests-passed), numTests);
	end
	endtask

	// -----------------------------
	// 2) DUT I/O
	// -----------------------------
	reg  [63:0] BusW;
	reg  [4:0]  RA, RB, RW;
	reg     	RegWr;
	reg     	Clk;
	wire [63:0] BusA, BusB;

	// Keep track of how many tests pass
	reg  [7:0]  passed = 0;

	// -----------------------------
	// 3) Instantiate RegisterFile
	// -----------------------------
	RegisterFile uut (
    	.BusA   (BusA),
    	.BusB   (BusB),
    	.BusW   (BusW),
    	.RA 	(RA),
    	.RB 	(RB),
    	.RW 	(RW),
    	.RegWr  (RegWr),
    	.Clk	(Clk)
	);

	// -----------------------------
	// 4) Clock Generation
	// -----------------------------
	initial Clk = 0;
	always #5 Clk = ~Clk;
	// 10ns period = toggles every 5ns

	// -----------------------------
	// 5) Test Procedure
	// -----------------------------
	integer i;
	initial begin
    	passed = 0;
    	for(i=0; i<31; i=i+1) begin
        	RW   = i[4:0];
        	BusW = i;
        	RegWr= 1'b1;
        	RA   = 5'd0;
        	RB   = 5'd0;
        	#10;
        	@(posedge Clk);  
    	end

    	RW   = 5'd31;
    	BusW = 64'hF00F00F00;
    	RegWr= 1'b1;
    	#10;
    	@(posedge Clk);  

    	// 1)
    	RA=5'd0; RB=5'd1; RW=5'd0; RegWr=1'b1; BusW=64'h0;
    	@(posedge Clk);
    	passTest(BusA, 64'd0, "T1-BusA=R0?", passed);
    	passTest(BusB, 64'd1, "T1-BusB=R1?", passed);

    	// 2)
    	RA=5'd2; RB=5'd3; RW=5'd1; RegWr=1'b0; BusW=64'h1000;
    	@(posedge Clk);
    	passTest(BusA, 64'd2, "T2-BusA=R2?", passed);
    	passTest(BusB, 64'd3, "T2-BusB=R3?", passed);

    	// 3)
    	RA=5'd4; RB=5'd5; RW=5'd0; RegWr=1'b1; BusW=64'h1000;
    	@(posedge Clk);
    	passTest(BusA, 64'd4, "T3-BusA=R4?", passed);
    	passTest(BusB, 64'd5, "T3-BusB=R5?", passed);

    	// 4)
    	RA=5'd6; RB=5'd7; RW=5'd10; RegWr=1'b1; BusW=64'h1010;
    	@(posedge Clk);
    	passTest(BusA, 64'd6, "T4-BusA=R6?", passed);
    	passTest(BusB, 64'd7, "T4-BusB=R7?", passed);

    	// 5)
    	RA=5'd8; RB=5'd9; RW=5'd11; RegWr=1'b1; BusW=64'h103000;
    	@(posedge Clk);
    	passTest(BusA, 64'd8,  "T5-BusA=R8?", passed);
    	passTest(BusB, 64'd9,  "T5-BusB=R9?", passed);

    	// 6)
    	RA=5'd10; RB=5'd11; RW=5'd12; RegWr=1'b0; BusW=64'h0;
    	@(posedge Clk);
    	passTest(BusA, 64'h1010, "T6-BusA=R10?", passed);
    	passTest(BusB, 64'h103000, "T6-BusB=R11?", passed);

    	// 7)
    	RA=5'd12; RB=5'd13; RW=5'd13; RegWr=1'b1; BusW=64'hABCD;
    	@(posedge Clk);
    	passTest(BusA, 64'd12,  "T7-BusA=R12=12?", passed);
    	passTest(BusB, 64'hABCD, "T7-BusB=R13=0xABCD?", passed);

    	// 8)
    	RA=5'd14; RB=5'd15; RW=5'd14; RegWr=1'b0; BusW=64'h9080009;
    	@(posedge Clk);
    	passTest(BusA, 64'd14, "T8-BusA=R14=14?", passed);
    	passTest(BusB, 64'd15, "T8-BusB=R15=15?", passed);

    	@(posedge Clk);
    	allPassed(passed, 16);
	end
endmodule



