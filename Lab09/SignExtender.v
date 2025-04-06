//`timescale 1ns/1ps

module SignExtender(ExtImm, Imm, Ctrl); 
   output reg [63:0] ExtImm; 
   input [25:0]  Imm; 
   input [2:0]	 Ctrl; 
   
   always @ (*) begin
      case(Ctrl)
       3'b000 : ExtImm = {52'b0, Imm[21:10]}; // I-type
       3'b001 : ExtImm = {{55{Imm[20]}}, Imm[20:12]}; // D-type
       3'b010 : ExtImm = {{38{Imm[25]}}, Imm[25:0]}; // B-type
       3'b011 : ExtImm = {{45{Imm[23]}}, Imm[23:5]}; // CB-type
       3'b100 : ExtImm = {{48'b0}, Imm[15:0]} << (Imm[17:16] * 16)// MOV-type
      endcase;
   end 
   
endmodule
