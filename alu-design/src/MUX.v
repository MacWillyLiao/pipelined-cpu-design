`timescale 1ns/1ns
module MUX (clk, ALUOut, HiOut, LoOut, Shifter, reset, Signal, dataOut);
	
	input clk;
	input reset;
	input [31:0] ALUOut;
	input [31:0] HiOut;
	input [31:0] LoOut;
	input [31:0] Shifter;
	input [5:0] Signal;
	output reg [31:0] dataOut;
	
	reg [31:0] temp;
	
	parameter AND  = 6'b100100;
	parameter OR   = 6'b100101;
	parameter ADD  = 6'b100000;
	parameter SUB  = 6'b100010;
	parameter SLT  = 6'b101010;
	parameter SLL  = 6'b000000;
	parameter MFHI = 6'b010000;
	parameter MFLO = 6'b010010;
	
	always @(posedge reset) begin
		if (reset) begin
			temp = 32'b0;
		end
	end
	
	always @(negedge clk) begin
	
		case (Signal)
			AND:  temp = ALUOut;
			OR:   temp = ALUOut;
			ADD:  temp = ALUOut;
			SUB:  temp = ALUOut;
			SLT:  temp = ALUOut;
			SLL:  temp = Shifter;
			MFHI: temp = HiOut;
			MFLO: temp = LoOut;
			default: temp = 32'b0;	
		endcase
		
		dataOut = temp;
	end

endmodule
