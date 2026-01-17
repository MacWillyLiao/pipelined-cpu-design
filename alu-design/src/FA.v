module FA (a, b, cin, cout, sum);
  
    input a, b, cin;
    output sum, cout;
    wire x, y, z;
    
    xor (x, a, b);
    xor (sum, x, cin);
    and (y, a, b);
    and (z, x, cin);
    or (cout, y, z);
  
endmodule
