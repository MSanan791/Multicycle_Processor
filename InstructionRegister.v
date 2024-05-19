module InstructionRegister(
 input [31:0] instr,
 input clk,
 input IRWrite,
 output [5:0] opcode,
 output [4:0] rs,
 output [4:0] rt,
 output [4:0] rd,
 output [15:0] im,
 output [5:0] funct,
 output [25:0] jump_address
);

reg [31:0] instruction_register;

always@(posedge clk) begin
 if(IRWrite)
  begin
   instruction_register <= instr;
  end
end

   assign opcode = instruction_register[31:26];
   assign rs = instruction_register[25:21];
   assign rt = instruction_register[20:16];
   assign rd = instruction_register[15:11];
   assign im = instruction_register [15:0];
   assign funct = instruction_register[5:0];
   assign jump_address = instruction_register[25:0];

endmodule


