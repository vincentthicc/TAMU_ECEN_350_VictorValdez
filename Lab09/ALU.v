`timescale 1ns/1ps

`define AND   4'b0000
`define OR    4'b0001
`define ADD   4'b0010
`define SUB   4'b0110
`define PassB 4'b0111
`define MOVK 4'b1000


module ALU(BusW, BusA, BusB, ALUCtrl, Zero, MovKMask);
    
    output  [63:0] BusW;
    input   [63:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    input   [63:0] MovKMask;
    output  Zero;
    
    reg     [63:0] BusW;
    
    always @(*) begin
        case(ALUCtrl)
        `AND: BusW = BusA & BusB;
        `OR: BusW = BusA | BusB;
	    `ADD: BusW = BusA + BusB;
	    `SUB: BusW = BusA - BusB;
	    `PassB: BusW = BusB;
        `MOVK: BusW = (BusA & MovKMask) | BusB;
        endcase
    end

    assign Zero = !BusW;
endmodule
