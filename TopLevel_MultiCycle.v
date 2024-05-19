module TopLevel_MultiCycle(
 input clk,
 input rst,
 output [1:0] PCSource,
 output [1:0] ALUSrcB,
 output ALUSrcA,
 output [2:0] ALUOp,
 output RegWrite,
 output RegDst,
 output IRWrite,
 output MemWrite,
 output MemToReg,
 output MemRead,
 output IorD,
 output PCWrite,
 output PCWriteCond,
 output [31:0] PC_Out, // For PC
 output [31:0] ALU_Out
);

wire [5:0] opcode;
reg [31:0] PC_In;

wire [31:0] ALUOut_Reg;

Control_Unit_MultiCycle mcu (.clk(clk), .rst(rst), .opcode(opcode), .PCSource(PCSource), .ALUSrcB(ALUSrcB), .ALUSrcA(ALUSrcA), .ALUOp(ALUOp), .RegWrite(RegWrite), .RegDst(RegDst), 
.IRWrite(IRWrite), .MemWrite(MemWrite), .MemToReg(MemToReg), .MemRead(MemRead), .IorD(IorD), .PCWrite(PCWrite), .PCWriteCond(PCWriteCond));
 
reg [31:0] RegA,RegB;
wire [31:0] Branch_Address;
wire [25:0] jump_address_temp;
wire [31:0] Jump_Address;

assign Jump_Address = {{PC_Out[31:26]},jump_address_temp};

always@* begin
 if (PCSource == 2'b00)
  PC_In <= ALU_Out;
 else if (PCSource == 2'b01)
  PC_In <= ALUOut_Reg;
 else if (PCSource == 2'b10)
  PC_In <= Jump_Address;
end

PC_MultiCycle pcm (.clk(clk), .rst(rst), .PC_In(PC_In), .PC_Out(PC_Out), .PCWrite(PCWrite), .PCWriteCond(PCWriteCond), .opcode(opcode));

wire [31:0] Mem_Data_Out;
// wire [31:0] write_data;  // not used
reg [31:0] address_input;
always@* begin
 if (IorD == 1'b1)
  address_input <= ALUOut_Reg;
 else
  address_input <= PC_Out;
end

Memory_MultiCycle mm (.clk(clk), .rst(rst), .address(address_input), .MemWrite(MemWrite), .MemRead(MemRead), .write_data(RegB), .Mem_Data_Out(Mem_Data_Out));

wire [4:0] rs,rt,rd;
wire [15:0] im_temp;
wire [31:0] im;
wire [5:0] funct;

InstructionRegister IR (.instr(Mem_Data_Out), .clk(clk), .IRWrite(IRWrite), .opcode(opcode), .rs(rs), .rt(rt), .rd(rd), .im(im_temp), .funct(funct), .jump_address(jump_address_temp));

assign im = {{16{im_temp[15]}},im_temp};

wire [31:0] Rdata1, Rdata2;

reg [4:0] rd_sel;
always@* begin
if (RegDst == 1'b1) begin 
rd_sel <= rd; 
end
else begin 
rd_sel <= rt; 
end
end

wire [31:0] MDR_Out;

memorydata_register MDR(.clk(clk), .Mem_Data_Out(Mem_Data_Out), .MDR_Out(MDR_Out));

reg [31:0] Data_In;

always@* begin
 if(MemToReg)
  Data_In <= MDR_Out;
 else 
  Data_In <= ALUOut_Reg;
end

RegisterFile RF (.Rdata1(Rdata1), .Rdata2(Rdata2), .Data_In(Data_In), .rs(rs), .rt(rt), .rd(rd_sel), .rst(rst), .clk(clk), .RegWrite(RegWrite));

always@(posedge clk) begin
 RegA <= Rdata1;
 RegB <= Rdata2;
end

wire [3:0] ALUopcode;
ALUControl AC (.ALUOp(ALUOp), .funct(funct), .ALUopcode(ALUopcode));

reg [31:0] Rs,Rt;

always@* begin
 if (ALUSrcA == 1'b0)
  Rs <= PC_Out;
 else
  Rs <= RegA; 
end

always@* begin
 if (ALUSrcB == 2'b00)
  Rt <= RegB;
 else if (ALUSrcB == 2'b01)
  Rt <= 1;
 else if (ALUSrcB == 2'b10 || ALUSrcB ==2'b11)
  Rt <= im;
end

ALU_MultiCycle AM (.Data_Out(ALU_Out), .zeroFlag(zeroFlag), .Rs(Rs), .Rt(Rt), .opcode(ALUopcode));

ALUOut_Register AOR (.clk(clk), .ALU_Result(ALU_Out), .ALUOut_Reg(ALUOut_Reg));

endmodule


