module EX_MEM (
    reset,
    clk,
    rfile_wn_in,
    rfile_wn_out,
    alu_out_in,
    alu_out_out,
    rfile_rd2_in,
    rfile_rd2_out,
    MemRead_in,
    MemRead_out,
    MemWrite_in,
    MemWrite_out,
    RegWrite_in,
    RegWrite_out,
    MemtoReg_in,
    MemtoReg_out
);
    
input clk, reset, MemtoReg_in, RegWrite_in, MemRead_in, MemWrite_in;
input [31:0] alu_out_in, rfile_rd2_in;
input [4:0] rfile_wn_in;

output MemtoReg_out, RegWrite_out, MemRead_out, MemWrite_out;
output [31:0] alu_out_out, rfile_rd2_out;
output [4:0] rfile_wn_out;

reg MemtoReg_out, RegWrite_out, MemRead_out, MemWrite_out;
reg [31:0] alu_out_out, rfile_rd2_out;
reg [4:0] rfile_wn_out;

always @(posedge clk) begin
    if (reset) begin
        rfile_rd2_out <= 32'b0;
        alu_out_out   <= 32'b0;
        rfile_wn_out  <= 5'b0;
        MemtoReg_out  <= 1'b0;
        RegWrite_out  <= 1'b0;
        MemRead_out   <= 1'b0;
        MemWrite_out  <= 1'b0;
    end else begin
        rfile_rd2_out <= rfile_rd2_in;
        alu_out_out   <= alu_out_in;
        rfile_wn_out  <= rfile_wn_in;
        MemtoReg_out  <= MemtoReg_in;
        RegWrite_out  <= RegWrite_in;
        MemRead_out   <= MemRead_in;
        MemWrite_out  <= MemWrite_in;
    end
end
endmodule
