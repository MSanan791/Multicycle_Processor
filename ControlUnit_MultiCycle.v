module Control_Unit_MultiCycle(
input clk,
input rst,
input [5:0] opcode,
output reg [1:0] PCSource,
output reg [1:0] ALUSrcB,
output reg ALUSrcA,
output reg [2:0] ALUOp,
output reg RegWrite,
output reg RegDst,
output reg IRWrite,
output reg MemWrite,
output reg MemToReg,
output reg MemRead,
output reg IorD,
output reg PCWrite,
output reg PCWriteCond
);

// opcodes
parameter lw = 6'b100011, beq = 6'b001000, RType = 6'b000000, 
sw = 6'b101011, jump = 6'b000010;
// states
parameter IDLE = 4'b0000, FETCH = 4'b0001, DECODE = 4'b0010;
parameter LW_Step3 = 4'b1000, LW_Step4 = 4'b1001, LW_Step5 = 
4'b1010;
parameter RType_Step3 = 4'b0100, RType_Step4 = 4'b0101;
parameter Branch_Step3 = 4'b0011;
parameter SW_Type1 = 4'b0110;
parameter SW_Type2 = 4'b0111;
parameter Jump = 4'b1101;
reg [3:0] current_State;
reg [3:0] next_State;

always@(posedge clk)
begin
if(rst)
current_State <= IDLE;
else
current_State <= next_State;
end

always@(*)
begin
next_State <= IDLE;
case(current_State)
IDLE : next_State <= FETCH;
FETCH: next_State <= DECODE;
DECODE: begin
case(opcode)
lw: next_State <= LW_Step3;
RType: next_State <= RType_Step3;
beq: next_State <= Branch_Step3;
sw: next_State <= SW_Type1;
jump: next_State <= Jump;
endcase
end

LW_Step3: next_State <= LW_Step4;
LW_Step4: next_State <= LW_Step5;
LW_Step5: next_State <= FETCH;
RType_Step3: next_State <= RType_Step4;
RType_Step4: next_State <= FETCH;
Branch_Step3: next_State <= FETCH;
Jump: next_State <= FETCH;
SW_Type1: next_State <= SW_Type2;
SW_Type2: next_State <= FETCH;
endcase
end

always@(*)
begin

 PCWrite = 0;
 PCWriteCond = 0;
 IorD = 0;
 MemRead = 0;
 MemWrite = 0;
 MemToReg = 0;
 IRWrite = 0;
 PCSource = 0;
 ALUOp = 0;
 ALUSrcB = 0;
 ALUSrcA = 0;
 RegWrite = 0;
 RegDst = 0;

case(current_State)
IDLE: begin 
 PCWrite = 0;
 PCWriteCond = 0;
 IorD = 0;
 MemRead = 0;
 MemWrite = 0;
 MemToReg = 0;
 IRWrite = 0;
 PCSource = 0;
 ALUOp = 0;
 ALUSrcB = 0;
 ALUSrcA = 0;
 RegWrite = 0;
 RegDst = 0;
 end
FETCH: begin 
 PCWrite = 1;
 IorD = 0;
 MemRead = 1;
 IRWrite = 1;
 PCSource = 2'b00;
 ALUSrcB = 2'b01;
 ALUSrcA = 0;
 ALUOp = 3'b010;
 end
DECODE: begin 
 PCWrite = 0;
 MemRead = 0;
 IRWrite = 0;
 ALUSrcB = 2'b11;
 ALUSrcA = 0;
 ALUOp = 3'b010;
 end
LW_Step3: begin
 ALUSrcB = 2'b10;
 ALUSrcA = 1;
 ALUOp = 3'b010;
 end
LW_Step4: begin
 MemRead = 1;
 IorD = 1;
 end
LW_Step5: begin
 RegDst = 0;
 RegWrite = 1;
 MemToReg = 1;
 end
RType_Step3: begin
 ALUSrcB = 2'b00;
 ALUSrcA = 1;
 ALUOp = 3'b000;
 end
RType_Step4: begin
 RegDst = 1;
 RegWrite = 1;
 MemToReg = 0;
 end
Branch_Step3: begin
 ALUSrcB = 2'b00;
 ALUSrcA = 1;
 ALUOp = 3'b001;
 PCWriteCond = 1;
 PCSource = 2'b01;
 end
Jump: begin
 PCWrite = 1;
 PCSource = 2'b10;
 end
SW_Type1: begin
 ALUOp = 3'b010;
 ALUSrcB = 2'b10;
 ALUSrcA = 1;
 end
SW_Type2: begin
 MemWrite = 1;
 IorD = 1;
 end
endcase
end

endmodule



