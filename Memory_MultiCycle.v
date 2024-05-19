module Memory_MultiCycle(
input clk,
input rst,
input [31:0] address,
input MemRead,
input MemWrite,
input [31:0] write_data,
output reg [31:0] Mem_Data_Out
);

reg [31:0] memory [31:0];
// First 16 ROM, Last 16 RAM
initial begin
// *** ROM ***
memory[0] = 32'b000000_00000_00001_00100_00000_100000; // add
memory[1] = 32'b000000_00100_00001_00100_00000_100000; // add
memory[2] = 32'b100011_00111_00100_00000_00000_000010; // LW addr = 2+15 = 17. 
memory[3] = 32'b000000_00100_00101_00010_00000_100010; //subtracting to check the lw values
memory[4] = 32'b000000_00101_00100_00110_00000_100100; // mult
//memory[4] = 32'b001000_00000_00001_00011_00000_100101; // addi
memory[5] = 32'b101011_00111_00111_00000_00000_000011; // SW, value = 5 :: 15 + 3, 18. Location 18, value saved
memory[6] = 32'b001000_01000_01001_00000_00000_000011; // Branch = 7+4 = 11
memory[7] = 32'b000000_00100_00001_00101_00000_100010; // sub 
memory[8] = 32'b000000_00100_00001_00011_00000_100000; // R-Type ADD
memory[9] = 32'b100011_00111_00101_00000_00000_000011; // LW from SW 
memory[10] = 32'b000010_00000_00000_00000_00000_001110; // Jump
memory[11] = 32'b000000_00101_00001_00011_00000_100000; // R-Type ADD
memory[12] = 32'b000000_00000_00001_00100_00000_100000; // add
memory[13] = 32'b000000_00000_00001_00100_00000_100000; // add
memory[14] = 32'b000000_00000_00001_00100_00000_100000; // add
memory[15] = 32'b000000_01000_00001_00101_00000_100010; // sub (R-Type) after branch comes here
// *** RAM ***
memory[16] = 32'd10; 
memory[17] = 32'd11; // add
memory[18] = 32'd12; // sub
memory[19] = 32'd13; // mult
memory[20] = 32'd14; // addi
memory[21] = 32'd15; // LW addr = 7, value = 5 :: rd/rt/destination = 4/100 
memory[22] = 32'd16; // R-Type ADD
memory[23] = 32'd17; // SW add = 7, value = 5 :: 5 + 3, 8. Location 8 value saved
memory[24] = 32'd18; // LW from SW 
memory[25] = 32'd19; // R-Type ADD
memory[26] = 32'd20; // Branch = 3 + PC + 1 = 11 + 3 = 15 but instr would be 14th
memory[27] = 32'd21; // add
memory[28] = 32'd22; // add
memory[29] = 32'd23; // add
memory[30] = 32'd24; // sub (R-Type) after branch comes here
memory[31] = 32'd25; // add
end

always@(*) begin
 if (MemRead)
  Mem_Data_Out <= memory[address]; 
end

always@(posedge clk) begin
 if (MemWrite)
  memory[address] <= write_data;
end

endmodule


