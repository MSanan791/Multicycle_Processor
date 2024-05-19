module ALUControl(
 input [2:0] ALUOp,
 input [5:0] funct,
 output reg [3:0] ALUopcode // goes into ALU (decides operation)
);

always@(*) begin
 // R-TYPE
 if(ALUOp == 3'b000) begin  // R-Type

  if (funct == 6'b100000) begin // add
   ALUopcode <= 4'b0000;
  end
  else if (funct == 6'b100010) begin // sub
   ALUopcode <= 4'b0001;
  end
  else if (funct == 6'b100100) begin // mult
   ALUopcode <= 4'b0010;
  end
  else if (funct == 6'b111000) begin // and
   ALUopcode <= 4'b0011;
  end
  else if (funct == 6'b111001) begin // or
   ALUopcode <= 4'b0100;
  end
  else if (funct == 6'b111100) begin // slt
   ALUopcode <= 4'b0001;
  end

 end

 // I-Type (addi,LW,SW)
 else if(ALUOp == 3'b010) begin 
  ALUopcode <= 4'b0000; // both for addi, LW,SW
 end

 // I-Type (andi)
 else if(ALUOp == 3'b011) begin 
  ALUopcode <= 4'b0011;
 end

 // I-Type (addie)
 else if(ALUOp == 3'b111) begin 
  ALUopcode <= 4'b0000;
 end

 // I-Type (ori)
 else if(ALUOp == 3'b100) begin 
  ALUopcode <= 4'b0100;
 end

 // Branch
 else if(ALUOp == 3'b001) begin 
  ALUopcode <= 4'b0001;
 end

 // Jump = ALUOp = XXX

end

endmodule

