module ALU1bit (a, b, less, inv, cin, cout, sel, result);
  
  input a, b, inv, less, cin;
  input [1:0] sel;
  output result;
  output cout;
  
  wire e1, e2, e3, sum;
  and (e1, a, b);
  or (e2, a, b);
  xor (e3, b, inv);
  
  FA fa (.a(a), .b(e3), .cin(cin), .cout(cout), .sum(sum));
  
  // mux
  
  assign result = (sel[1]) ? (sel[0] ? less : sum) : (sel[0] ? e2 : e1);  

endmodule
