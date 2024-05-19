module ALU_MultiCycle(
 output reg [31:0] Data_Out,
 output reg zeroFlag,
 input [31:0] Rs,
 input [31:0] Rt,
 input [3:0] opcode
);

always@(*) begin
case(opcode)
4'b0000: begin 
Data_Out = Rs+Rt;
end
4'b0001: begin 
 Data_Out = Rs-Rt;
 // For BEQ
 if (Data_Out == 32'd0) begin
  zeroFlag <= 1'b1;
 end
 else begin zeroFlag<=0; end
end
4'b0010: begin
Data_Out = Rs*Rt;
end
4'b0011: begin
Data_Out = Rs&Rt;
end
4'b0100: begin
Data_Out = Rs|Rt;
end
default: begin
Data_Out = 32'd0;
end
endcase
end

endmodule

