module IF_ID (reset, clk, Instr_in, Instr_out, pc_incr_in, pc_incr_out);

input clk, reset;
input [31:0] Instr_in, pc_incr_in;
output [31:0] Instr_out, pc_incr_out;

reg [31:0] Instr_out, pc_incr_out;

always @(posedge clk) begin
    if (reset) begin
        Instr_out <= 32'b0;
        pc_incr_out <= 32'b0;
    end else begin
        Instr_out <= Instr_in;  
        pc_incr_out <= pc_incr_in;
    end
end
    
endmodule
