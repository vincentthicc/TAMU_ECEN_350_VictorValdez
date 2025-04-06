//`timescale 1ns/1ps

module SignExtender(ExtImm, Imm, Ctrl); 
   output reg [63:0] ExtImm; 
   input [25:0]  Imm; 
   input [1:0]	 Ctrl; 

   always @ (*) begin
      case(Ctrl)
       2'b00 : ExtImm = {52'b0, Imm[21:10]}; // I-type
       2'b01 : ExtImm = {{55{Imm[20]}}, Imm[20:12]}; // D-type
       2'b10 : ExtImm = {{38{Imm[25]}}, Imm[25:0]}; // B-type
       2'b11 : ExtImm = {{45{Imm[23]}}, Imm[23:5]}; // CB-type
      endcase;
   end 
   
endmodule
