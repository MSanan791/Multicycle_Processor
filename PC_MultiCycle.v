module PC_MultiCycle(
input clk,
input rst,
input PCWrite, // for Normal + Jump
input PCWriteCond, // for Branch
input [5:0] opcode,
input [31:0] PC_In,
output reg [31:0] PC_Out
);

always@(posedge clk, posedge rst) begin
if(rst)
PC_Out <= 0;

// Normal
else if (PCWrite == 1'b1)
PC_Out <= PC_In;

// Branch
else if (PCWriteCond == 1'b1)
PC_Out <= PC_In;

// Jump
else if (PCWrite == 1'b1 && opcode == 5'd2)
PC_Out <= PC_In;

end
endmodule


