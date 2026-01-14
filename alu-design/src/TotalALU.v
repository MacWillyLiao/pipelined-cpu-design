`timescale 1ns/1ns
module TotalALU( clk, dataA, dataB, Signal, Output, reset ) ;
input reset ;
input clk ;
input [31:0] dataA ;
input [31:0] dataB ;
input [5:0] Signal ;
output [31:0] Output ;

wire reset ;
wire [5:0]  SignaltoALU ;
wire [5:0]  SignaltoSHT ;
wire [5:0]  SignaltoMUL ;
wire [5:0]  SignaltoMUX ;
wire [5:0] MUL_counter ;
wire [31:0] ALUOut, ShifterOut, HiOut, LoOut, dataOut ;
wire [63:0] MulOut ;

ALUControl ALUControl( .clk(clk), .Signal(Signal), .SignaltoALU(SignaltoALU), .SignaltoSHT(SignaltoSHT), .SignaltoMUL(SignaltoMUL), .SignaltoMUX(SignaltoMUX), .MUL_counter(MUL_counter) ) ;
ALU ALU( .dataA(dataA), .dataB(dataB), .Signal(SignaltoALU), .dataOut(ALUOut) ) ;
Multiplier Multiplier( .clk(clk), .dataA(dataA), .dataB(dataB), .Signal(SignaltoMUL), .dataOut(MulOut), .reset(reset), .counter(MUL_counter) ) ;
Shifter Shifter( .dataA(dataA), .dataB(dataB), .Signal(SignaltoSHT), .dataOut(ShifterOut) ) ;
HiLo HiLo( .clk(clk), .MulAns(MulOut), .HiOut(HiOut), .LoOut(LoOut), .reset(reset) ) ;
MUX MUX( .clk(clk), .ALUOut(ALUOut), .HiOut(HiOut), .LoOut(LoOut), .Shifter(ShifterOut), .reset(reset), .Signal(SignaltoMUX), .dataOut(dataOut) ) ;

assign Output = dataOut ;

endmodule