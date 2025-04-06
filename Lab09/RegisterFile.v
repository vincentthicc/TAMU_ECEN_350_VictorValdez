`timescale 1ns / 1ps

module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    output [63:0] BusA;
    output [63:0] BusB;
    input [63:0] BusW;
    input [4:0] RA;
    input [4:0] RB;
    input [4:0] RW;
    input RegWr;
    input Clk;
    reg [63:0] registers [31:0];

    initial begin
    for (integer i = 0; i < 32; i = i + 1) begin
	registers[i] = 64'd0;
    end
    end

    assign #2 BusA = (RA == 5'd31) ? 64'h0 : registers[RA];
    assign #2 BusB = (RB == 5'd31) ? 64'h0 : registers[RB];

    always@(negedge Clk) begin
        if(RegWr && (RW != 5'd31)) registers[RW] <= #3 BusW;
    end
endmodule