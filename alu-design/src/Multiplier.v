`timescale 1ns/1ns
module Multiplier (clk, dataA, dataB, Signal, dataOut, reset, counter);
	
	input clk;
	input reset;
	input [31:0] dataA;  // multiplicand
	input [31:0] dataB;  // multiplier
	input [5:0] Signal;
	input [5:0] counter;
	output [63:0] dataOut;
	
	reg [63:0] temp;
	reg [63:32] tempHI;
	reg [31:0] tempLO;
	
	parameter MULTU = 6'b011001;
	parameter OUT = 6'b111111;
	
	always @(posedge reset) begin
		if (reset) begin
	        temp = 64'b0;
	        tempHI = 32'b0;
	        tempLO = 32'b0;
	    end
	end
	
	always @(posedge clk) begin
		case (Signal)
			MULTU: begin
				if (dataB[counter]) begin
					tempHI = tempHI + dataA;
				end
			    else begin
				  	tempHI = tempHI;
				end
			   
			  	{tempHI, tempLO} = {tempHI, tempLO} >> 1;
			end
			OUT: begin
				temp = {tempHI, tempLO};
				#330 ;
			end
		endcase
	end
	
	assign dataOut = temp;

endmodule
