module MEM_WB (reset, clk, rfile_wn_in, rfile_wn_out, alu_out_in, alu_out_out,
               rd_in, rd_out, MemtoReg_in, MemtoReg_out, RegWrite_in, RegWrite_out);

    input clk, reset, MemtoReg_in, RegWrite_in;
    input [31:0] alu_out_in, rd_in;
    input [4:0] rfile_wn_in;
    
    output MemtoReg_out, RegWrite_out;
    output [31:0] alu_out_out, rd_out;
    output [4:0] rfile_wn_out;
    
    reg MemtoReg_out, RegWrite_out;
    reg [31:0] alu_out_out, rd_out;
    reg [4:0] rfile_wn_out;
    
    always @(posedge clk) begin
        if (reset) begin
            alu_out_out <= 32'b0;
            rd_out <= 32'b0;
            rfile_wn_out <= 5'b0;
            MemtoReg_out <= 1'b0;
            RegWrite_out <= 1'b0;
        end else begin
            alu_out_out <= alu_out_in;
            rd_out <= rd_in;
            rfile_wn_out <= rfile_wn_in;
            MemtoReg_out <= MemtoReg_in;
            RegWrite_out <= RegWrite_in;
        end
    end

endmodule
