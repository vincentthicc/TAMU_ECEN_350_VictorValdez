`timescale 1ns / 1ps
/*
 * Module: InstructionMemory
 *
 * Implements read-only instruction memory
 * 
 */
module InstructionMemory(Data, Address);
   parameter T_rd = 20;
   parameter MemSize = 40;
   
   output [31:0] Data;
   input [63:0]  Address;
   reg [31:0] 	 Data;
   
   /*
    * ECEN 350 Processor Test Functions
    * Texas A&M University
    */
   
   always @ (Address) begin

      case(Address)

	/* Test Program 1:
	 * Program loads constants from the data memory. Uses these constants to test
	 * the following instructions: LDUR, ORR, AND, CBZ, ADD, SUB, STUR and B.
	 * 
	 * Assembly code for test:
	 * 
	 * 0: LDUR X9, [XZR, 0x0]    //Load 1 into x9
	 * 4: LDUR X10, [XZR, 0x8]   //Load a into x10
	 * 8: LDUR X11, [XZR, 0x10]  //Load 5 into x11
	 * C: LDUR X12, [XZR, 0x18]  //Load big constant into x12
	 * 10: LDUR X13, [XZR, 0x20]  //load a 0 into X13
	 * 
	 * 14: ORR X10, X10, X11  //Create mask of 0xf
	 * 18: AND X12, X12, X10  //Mask off low order bits of big constant
	 * 
	 * loop:
	 * 1C: CBZ X12, end  //while X12 is not 0
	 * 20: ADD X13, X13, X9  //Increment counter in X13
	 * 24: SUB X12, X12, X9  //Decrement remainder of big constant in X12
	 * 28: B loop  //Repeat till X12 is 0
	 * 2C: STUR X13, [XZR, 0x20]  //store back the counter value into the memory location 0x20
	 */
	
	63'h000: Data = 32'hF84003E9;
	63'h004: Data = 32'hF84083EA;
	63'h008: Data = 32'hF84103EB;
	63'h00c: Data = 32'hF84183EC;
	63'h010: Data = 32'hF84203ED;
	63'h014: Data = 32'hAA0B014A;
	63'h018: Data = 32'h8A0A018C;
	63'h01c: Data = 32'hB400008C;
	63'h020: Data = 32'h8B0901AD;
	63'h024: Data = 32'hCB09018C;
	63'h028: Data = 32'h17FFFFFD;
	63'h02c: Data = 32'hF80203ED;
	63'h030: Data = 32'hF84203ED;  //One last load to place stored value on memdbus for test checking.

	/* Add code for your tests here */

		/* Test Program 2 (Question 5):
	 * Program loads constants from the data memory. Uses these constants to test
	 * the following instructions: MOVZ and MOVK
	 * 
	 * Assembly code for test:
	 * 
	 * 34: MOVZ X9, 0xdef0
	 * 38: MOVK X9, 0x9abc, LSL #16
	 * 3C: MOVK X9, 0x5678, LSL #32
	 * 40: MOVK X9, 0x1234, LSL #48
	 * 
	 * 44: MOVZ X10, 0x28
	 * 48: STUR X9, [X10, #0]
	 * 
	 * 4C: LDUR X10, [X10, #0]
	 */

	63'h034: Data = 32'hD29BDE09;
	63'h038: Data = 32'hF2B35789;
	63'h03c: Data = 32'hF2CACF09;
	63'h040: Data = 32'hF2E24689;
	63'h044: Data = 32'hD280050A;
	63'h048: Data = 32'hF8000149;
	63'h04c: Data = 32'hF840014A;
	
	default: Data = 32'hXXXXXXXX;
      endcase
   end
endmodule
