`include "suma.v"
`include "mult.v"

module top(input [3:0] A, B, output [7:0] OUT1, output [7:0] OUT2);
  
  suma sama1( .a(A), .b(B), .out(OUT1));
  mult mult1( .a(A), .b(B), .out(OUT2));
  
  
endmodule
