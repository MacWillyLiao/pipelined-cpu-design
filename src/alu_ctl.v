module alu_ctl (ALUOp, Funct, ALUOperation);
    
    input [1:0] ALUOp;
    input [5:0] Funct;
    output [5:0] ALUOperation;
    reg [5:0] ALUOperation;

    // symbolic constants for instruction function code
    parameter F_add = 6'd32;
    parameter F_sub = 6'd34;
    parameter F_and = 6'd36;
    parameter F_or = 6'd37;
    parameter F_slt = 6'd42;
    parameter F_multu = 6'd25;
    parameter F_mfhi = 6'd16;
    parameter F_mflo = 6'd18;

    always @(ALUOp or Funct) begin
        case (ALUOp) 
            2'b00: ALUOperation = F_add;
            2'b01: ALUOperation = F_sub;
            2'b10: case (Funct) 
                        F_add  : ALUOperation = F_add;
                        F_sub  : ALUOperation = F_sub;
                        F_and  : ALUOperation = F_and;
                        F_or   : ALUOperation = F_or;
                        F_slt  : ALUOperation = F_slt;
                        F_multu: ALUOperation = F_multu;
                        F_mfhi : ALUOperation = F_mfhi;
                        F_mflo : ALUOperation = F_mflo;
                        default: ALUOperation = 3'bxxx;  
                    endcase
            2'b11: ALUOperation = F_and;
            default ALUOperation = 3'bxxx;  // nop
        endcase
    end
    
endmodule
