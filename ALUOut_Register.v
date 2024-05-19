module ALUOut_Register(
 input clk,
 input [31:0] ALU_Result,
 output reg [31:0] ALUOut_Reg
);

always@(posedge clk) begin
 ALUOut_Reg <= ALU_Result;
end

endmodule

