module NextPCLogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
   input [63:0] CurrentPC, SignExtImm64; 
   input 	Branch, ALUZero, Uncondbranch; 
   output reg [63:0] NextPC; 
	
	wire branchMUX = (Branch & ALUZero) | Uncondbranch;

   /* write your code here */ 
	always@(*) begin
	if (branchMUX) NextPC = CurrentPC + (SignExtImm64 << 2);
	else NextPC = CurrentPC + 64'd4;
	end

endmodule
