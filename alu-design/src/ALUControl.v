`timescale 1ns/1ns
module ALUControl( clk, Signal, SignaltoALU, SignaltoSHT, SignaltoMUL, SignaltoMUX, MUL_counter );
input clk ;
input [5:0] Signal ;
output [5:0] SignaltoALU ;
output [5:0] SignaltoSHT ;
output [5:0] SignaltoMUL ;
output [5:0] SignaltoMUX ;
output [5:0] MUL_counter ;

//   Signal ( 6-bits )
//   AND  : 36
//   OR   : 37
//   ADD  : 32
//   SUB  : 34
//   SLT  : 42
//   SLL  : 00
//   MULTU: 25

reg [5:0] temp ;
reg [5:0] counter ;

parameter MULTU = 6'b011001 ;

always @( Signal )
begin
  if ( Signal == MULTU )
  begin
    counter = 0 ;
  end
end

always @( posedge clk )
begin
  temp = Signal ;
  if ( Signal == MULTU )
  begin
    counter = counter + 1 ;
    if ( counter == 32 )
    begin
      temp = 6'b111111 ; // Open HiLo reg for MUL
      counter = 0 ;
    end
  end
end

assign SignaltoALU = temp ;
assign SignaltoSHT = temp ;
assign SignaltoMUL = temp ;
assign SignaltoMUX = temp ;
assign MUL_counter = counter ;

endmodule