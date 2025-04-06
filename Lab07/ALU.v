`define AND   4'b0000
`define OR    4'b0001
`define ADD   4'b0010
`define SUB   4'b0110
`define PassB 4'b0111


module ALU(BusW, BusA, BusB, ALUCtrl, Zero);
    
    output  [63:0] BusW;
    input   [63:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    output  Zero;
    
    reg     [63:0] BusW;
    
    always @(*) begin
        case(ALUCtrl)
            `AND: BusW = BusA & BusB;
            `OR: BusW = BusA | BusB;
	    `ADD: BusW = BusA + BusB;
	    `SUB: BusW = BusA - BusB;
	    `PassB: BusW = BusB;
        endcase
    end

    assign Zero = !BusW;
endmodule
