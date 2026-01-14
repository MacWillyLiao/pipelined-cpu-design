module muxNop( instr, Nop );
    input  [31:0] instr;
    output Nop;

    assign Nop = ( instr == 32'b00000000000000000000000000000000 ) ? 1'b1 : 1'b0 ;
endmodule
