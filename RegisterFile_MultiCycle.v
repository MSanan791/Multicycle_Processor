module RegisterFile(
 output [31:0] Rdata1,
 output [31:0] Rdata2,
 input [31:0] Data_In,
 input [4:0] rs,
 input [4:0] rt,
 input [4:0] rd,
 input rst,
 input clk,
 input RegWrite
);

reg [31:0] regfile [31:0];
integer i;

initial begin 
regfile[0] = 32'd54;
regfile[1] = 32'd55;
regfile[2] = 32'd56;
regfile[3] = 32'd57;
regfile[4] = 32'd58;
regfile[5] = 32'd59;
regfile[6] = 32'd60;
regfile[7] = 32'd15;
regfile[8] = 32'd10;
regfile[9] = 32'd10;
end

assign Rdata1 = regfile[rs];
assign Rdata2 = regfile[rt];

always@(posedge clk, posedge rst) begin
 if(rst) begin
  for(i = 16; i < 31; i = i + 1)
   regfile[i] <= i;
 end
 if(RegWrite)
  regfile[rd] <= Data_In;
 end

endmodule
