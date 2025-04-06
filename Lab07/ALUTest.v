`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:02:47 03/05/2009
// Design Name:   ALU
// Module Name:   E:/350/Lab8/ALU/ALUTest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 32
module ALUTest_v;

	task passTest;
		input [64:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [63:0] BusA;
	reg [63:0] BusB;
	reg [3:0] ALUCtrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusW;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.BusW(BusW), 
		.Zero(Zero), 
		.BusA(BusA), 
		.BusB(BusB), 
		.ALUCtrl(ALUCtrl)
	);

	initial begin
		// Initialize Inputs
		BusA = 0;
		BusB = 0;
		ALUCtrl = 0;
		passed = 0;

		$dumpfile("ALUTest_v.vcd");
		$dumpvars(0, ALUTest_v);

	      //============ AND Tests ============

	      // AND1: 0x8776 & 0x3929 => 0x0120, Zero=0
	      {BusA, BusB, ALUCtrl} = {64'h8776, 64'h3929, 4'h0}; #40;
	      passTest({Zero, BusW}, 65'h0_0000000000000120, "AND1 (0x8776 & 0x3929)", passed);

	      // AND2: 0x8015 & 0x9559 => 0x8011, Zero=0
	      {BusA, BusB, ALUCtrl} = {64'h8015, 64'h9559, 4'h0}; #40;
	      passTest({Zero, BusW}, 65'h0_0000000000008011, "AND2 (0x8015 & 0x9559)", passed);

	      // AND3: 0x0000 & 0x0000 => 0x0000, Zero=1
	      {BusA, BusB, ALUCtrl} = {64'h0000, 64'h0000, 4'h0}; #40;
	      passTest({Zero, BusW}, 65'h1_0000000000000000, "AND3 (0x0000 & 0x0000)", passed);

	      //============ OR Tests ============

	      // OR1: 0x1165 | 0x7381 => 0x73E5, Zero=0
	      {BusA, BusB, ALUCtrl} = {64'h1165, 64'h7381, 4'h1}; #40;
	      passTest({Zero, BusW}, 65'h0_00000000000073E5, "OR1 (0x1165 | 0x7381)", passed);

	      // OR2: 0x9667 | 0x6559 => 0xF77F, Zero=0
	      {BusA, BusB, ALUCtrl} = {64'h9667, 64'h6559, 4'h1}; #40;
	      passTest({Zero, BusW}, 65'h0_000000000000F77F, "OR2 (0x9667 | 0x6559)", passed);

	      // OR3: 0x0000 | 0x0000 => 0x0000, Zero=1
	      {BusA, BusB, ALUCtrl} = {64'h0000, 64'h0000, 4'h1}; #40;
	      passTest({Zero, BusW}, 65'h1_0000000000000000, "OR3 (0x0000 | 0x0000)", passed);

	      //============ ADD Tests ============

	      // ADD1: 0x5912 + 0x4009 => 0x991B, Zero=0
	      {BusA, BusB, ALUCtrl} = {64'h5912, 64'h4009, 4'h2}; #40;
	      passTest({Zero, BusW}, 65'h0_000000000000991B, "ADD1 (0x5912 + 0x4009)", passed);

	      // ADD2: 0x7128 + 0x9138 => 0x10260, Zero=0
	      {BusA, BusB, ALUCtrl} = {64'h7128, 64'h9138, 4'h2}; #40;
	      passTest({Zero, BusW}, 65'h0_0000000000010260, "ADD2 (0x7128 + 0x9138)", passed);

	      // ADD3: 0x0000 + 0x0000 => 0x0000, Zero=1
	      {BusA, BusB, ALUCtrl} = {64'h0000, 64'h0000, 4'h2}; #40;
	      passTest({Zero, BusW}, 65'h1_0000000000000000, "ADD3 (0x0000 + 0x0000)", passed);

	      //============ SUB Tests ============

	      // SUB1: 0x3878 - 0x9716 => 0xEA62, Zero=0
	      {BusA, BusB, ALUCtrl} = {64'h3878, 64'h9716, 4'h6}; #40;
	      passTest({Zero, BusW}, 65'h0_FFFFFFFFFFFFA162, "SUB1 (0x3878 - 0x9716)", passed);

	      // SUB2: 0x3804 - 0x2580 => 0x1284, Zero=0
	      {BusA, BusB, ALUCtrl} = {64'h3804, 64'h2580, 4'h6}; #40;
	      passTest({Zero, BusW}, 65'h0_0000000000001284, "SUB2 (0x3804 - 0x2580)", passed);

	      // SUB3: 0x0000 - 0x0000 => 0x0000, Zero=1
	      {BusA, BusB, ALUCtrl} = {64'h0000, 64'h0000, 4'h6}; #40;
	      passTest({Zero, BusW}, 65'h1_0000000000000000, "SUB3 (0x0000 - 0x0000)", passed);

	      //============ PassB Tests ============

	      // PassB1: BusB=0x6897 => 0x6897, Zero=0
	      {BusA, BusB, ALUCtrl} = {64'h3804, 64'h6897, 4'h7}; #40;
	      passTest({Zero, BusW}, 65'h0_0000000000006897, "PassB1 (BusB=0x6897)", passed);

	      // PassB2: BusB=0x7623 => 0x7623, Zero=0
	      {BusA, BusB, ALUCtrl} = {64'h1650, 64'h7623, 4'h7}; #40;
	      passTest({Zero, BusW}, 65'h0_0000000000007623, "PassB2 (BusB=0x7623)", passed);

	      // PassB3: BusB=0x0000 => 0x0000, Zero=1
	      {BusA, BusB, ALUCtrl} = {64'h0000, 64'h0000, 4'h7}; #40;
	      passTest({Zero, BusW}, 65'h1_0000000000000000, "PassB3 (BusB=0x0000)", passed);


		allPassed(passed, 15);
	end
      
endmodule

