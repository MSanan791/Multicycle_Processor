module memorydata_register (
 input clk, 
 input [31:0] Mem_Data_Out,
 output reg [31:0] MDR_Out
);

always@(posedge clk) begin
 MDR_Out <= Mem_Data_Out;
end

endmodule
