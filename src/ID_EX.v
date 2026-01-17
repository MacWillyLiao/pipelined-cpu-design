module ID_EX (reset, clk, RD1_in, RD1_out, RD2_in, RD2_out, extend_immed_in, extend_immed_out,
              funct_in, funct_out, rt_in, rt_out, rd_in, rd_out, RegDst_in, RegDst_out, 
              ALUSrc_in, ALUSrc_out, MemtoReg_in, MemtoReg_out, RegWrite_in, RegWrite_out,
              MemRead_in, MemRead_out, MemWrite_in, MemWrite_out, ALUOp_in, ALUOp_out);

input clk, reset;
input RegDst_in, ALUSrc_in, MemtoReg_in, RegWrite_in, MemRead_in, MemWrite_in;
input [31:0] RD1_in, RD2_in, extend_immed_in;
input [5:0] funct_in;
input [4:0] rt_in, rd_in;
input [1:0] ALUOp_in;

output [31:0] RD1_out, RD2_out, extend_immed_out;
output [5:0] funct_out;
output [4:0] rt_out, rd_out;
output [1:0] ALUOp_out;
output RegDst_out, ALUSrc_out, MemtoReg_out, RegWrite_out, MemRead_out, MemWrite_out;

reg [31:0] RD1_out, RD2_out, extend_immed_out;
reg [5:0] funct_out;
reg [4:0] rt_out, rd_out;
reg [1:0] ALUOp_out;
reg RegDst_out, ALUSrc_out, MemtoReg_out, RegWrite_out, MemRead_out, MemWrite_out;

always @(posedge clk) begin
    if (reset) begin
        RD1_out <= 32'b0;
        RD2_out <= 32'b0;
        extend_immed_out <= 32'b0;
        funct_out <= 6'b0;
        rt_out <= 5'b0;
        rd_out <= 5'b0;
        ALUOp_out <= 2'b0;
        RegDst_out <= 1'b0;
        ALUSrc_out <= 1'b0;
        MemtoReg_out <= 1'b0;
        RegWrite_out <= 1'b0;
        MemRead_out <= 1'b0;
        MemWrite_out <= 1'b0;
    end else begin
        RD1_out <= RD1_in;
        RD2_out <= RD2_in;
        extend_immed_out <= extend_immed_in;
        funct_out <= funct_in;
        rt_out <= rt_in;
        rd_out <= rd_in;
        ALUOp_out <= ALUOp_in;
        RegDst_out <= RegDst_in;
        ALUSrc_out <= ALUSrc_in;
        MemtoReg_out <= MemtoReg_in;
        RegWrite_out <= RegWrite_in;
        MemRead_out <= MemRead_in;
        MemWrite_out <= MemWrite_in;
    end
end

endmodule
