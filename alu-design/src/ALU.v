`timescale 1ns/ 1ns
module ALU (dataA, dataB, Signal, dataOut);

    input [31:0] dataA;
    input [31:0] dataB;
    input [5:0] Signal;
    output [31:0] dataOut;
    
    // table (3-bits)
    // 000 and
    // 001 or
    // 010 add
    // 110 sub
    // 111 slt
    
    wire [31:0] temp;
    wire [1:0] sel;
    wire cin;
    wire inv;
    wire [31:0] cout;
    wire [31:0] less;
    
    parameter SUB = 6'b100010;
      
    assign sel[0] = Signal[3] ? 1'b1 : Signal[0];
    assign sel[1] = ~Signal[2];
    assign inv = Signal[1];
    assign cin = (Signal == SUB) ? 1'b1 : 1'b0;
    
    assign less = (dataA < dataB) ? dataB : dataA;
    
    ALU1bit alu0 (.a(dataA[0]), .b(dataB[0]), .less(less[0]), .inv(inv), .cin(cin), .cout(cout[0]), .sel(sel), .result(temp[0]));
    ALU1bit alu1 (.a(dataA[1]), .b(dataB[1]), .less(less[1]), .inv(inv), .cin(cout[0]), .cout(cout[1]), .sel(sel), .result(temp[1]));
    ALU1bit alu2 (.a(dataA[2]), .b(dataB[2]), .less(less[2]), .inv(inv), .cin(cout[1]), .cout(cout[2]), .sel(sel), .result(temp[2]));
    ALU1bit alu3 (.a(dataA[3]), .b(dataB[3]), .less(less[3]), .inv(inv), .cin(cout[2]), .cout(cout[3]), .sel(sel), .result(temp[3]));
    ALU1bit alu4 (.a(dataA[4]), .b(dataB[4]), .less(less[4]), .inv(inv), .cin(cout[3]), .cout(cout[4]), .sel(sel), .result(temp[4]));
    ALU1bit alu5 (.a(dataA[5]), .b(dataB[5]), .less(less[5]), .inv(inv), .cin(cout[4]), .cout(cout[5]), .sel(sel), .result(temp[5]));
    ALU1bit alu6 (.a(dataA[6]), .b(dataB[6]), .less(less[6]), .inv(inv), .cin(cout[5]), .cout(cout[6]), .sel(sel), .result(temp[6]));
    ALU1bit alu7 (.a(dataA[7]), .b(dataB[7]), .less(less[7]), .inv(inv), .cin(cout[6]), .cout(cout[7]), .sel(sel), .result(temp[7]));
    ALU1bit alu8 (.a(dataA[8]), .b(dataB[8]), .less(less[8]), .inv(inv), .cin(cout[7]), .cout(cout[8]), .sel(sel), .result(temp[8]));
    ALU1bit alu9 (.a(dataA[9]), .b(dataB[9]), .less(less[9]), .inv(inv), .cin(cout[8]), .cout(cout[9]), .sel(sel), .result(temp[9]));
    ALU1bit alu10 (.a(dataA[10]), .b(dataB[10]), .less(less[10]), .inv(inv), .cin(cout[9]), .cout(cout[10]), .sel(sel), .result(temp[10]));
    ALU1bit alu11 (.a(dataA[11]), .b(dataB[11]), .less(less[11]), .inv(inv), .cin(cout[10]), .cout(cout[11]), .sel(sel), .result(temp[11]));
    ALU1bit alu12 (.a(dataA[12]), .b(dataB[12]), .less(less[12]), .inv(inv), .cin(cout[11]), .cout(cout[12]), .sel(sel), .result(temp[12]));
    ALU1bit alu13 (.a(dataA[13]), .b(dataB[13]), .less(less[13]), .inv(inv), .cin(cout[12]), .cout(cout[13]), .sel(sel), .result(temp[13]));
    ALU1bit alu14 (.a(dataA[14]), .b(dataB[14]), .less(less[14]), .inv(inv), .cin(cout[13]), .cout(cout[14]), .sel(sel), .result(temp[14]));
    ALU1bit alu15 (.a(dataA[15]), .b(dataB[15]), .less(less[15]), .inv(inv), .cin(cout[14]), .cout(cout[15]), .sel(sel), .result(temp[15]));
    ALU1bit alu16 (.a(dataA[16]), .b(dataB[16]), .less(less[16]), .inv(inv), .cin(cout[15]), .cout(cout[16]), .sel(sel), .result(temp[16]));
    ALU1bit alu17 (.a(dataA[17]), .b(dataB[17]), .less(less[17]), .inv(inv), .cin(cout[16]), .cout(cout[17]), .sel(sel), .result(temp[17]));
    ALU1bit alu18 (.a(dataA[18]), .b(dataB[18]), .less(less[18]), .inv(inv), .cin(cout[17]), .cout(cout[18]), .sel(sel), .result(temp[18]));
    ALU1bit alu19 (.a(dataA[19]), .b(dataB[19]), .less(less[19]), .inv(inv), .cin(cout[18]), .cout(cout[19]), .sel(sel), .result(temp[19]));
    ALU1bit alu20 (.a(dataA[20]), .b(dataB[20]), .less(less[20]), .inv(inv), .cin(cout[19]), .cout(cout[20]), .sel(sel), .result(temp[20]));
    ALU1bit alu21 (.a(dataA[21]), .b(dataB[21]), .less(less[21]), .inv(inv), .cin(cout[20]), .cout(cout[21]), .sel(sel), .result(temp[21]));
    ALU1bit alu22 (.a(dataA[22]), .b(dataB[22]), .less(less[22]), .inv(inv), .cin(cout[21]), .cout(cout[22]), .sel(sel), .result(temp[22]));
    ALU1bit alu23 (.a(dataA[23]), .b(dataB[23]), .less(less[23]), .inv(inv), .cin(cout[22]), .cout(cout[23]), .sel(sel), .result(temp[23]));
    ALU1bit alu24 (.a(dataA[24]), .b(dataB[24]), .less(less[24]), .inv(inv), .cin(cout[23]), .cout(cout[24]), .sel(sel), .result(temp[24]));
    ALU1bit alu25 (.a(dataA[25]), .b(dataB[25]), .less(less[25]), .inv(inv), .cin(cout[24]), .cout(cout[25]), .sel(sel), .result(temp[25]));
    ALU1bit alu26 (.a(dataA[26]), .b(dataB[26]), .less(less[26]), .inv(inv), .cin(cout[25]), .cout(cout[26]), .sel(sel), .result(temp[26]));
    ALU1bit alu27 (.a(dataA[27]), .b(dataB[27]), .less(less[27]), .inv(inv), .cin(cout[26]), .cout(cout[27]), .sel(sel), .result(temp[27]));
    ALU1bit alu28 (.a(dataA[28]), .b(dataB[28]), .less(less[28]), .inv(inv), .cin(cout[27]), .cout(cout[28]), .sel(sel), .result(temp[28]));
    ALU1bit alu29 (.a(dataA[29]), .b(dataB[29]), .less(less[29]), .inv(inv), .cin(cout[28]), .cout(cout[29]), .sel(sel), .result(temp[29]));
    ALU1bit alu30 (.a(dataA[30]), .b(dataB[30]), .less(less[30]), .inv(inv), .cin(cout[29]), .cout(cout[30]), .sel(sel), .result(temp[30]));
    ALU1bit alu31 (.a(dataA[31]), .b(dataB[31]), .less(less[31]), .inv(inv), .cin(cout[30]), .cout(cout[31]), .sel(sel), .result(temp[31]));
    
    assign dataOut = temp;

endmodule
