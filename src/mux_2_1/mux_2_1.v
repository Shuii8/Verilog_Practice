module test(input sel, input [8:0] a, b, output [8:0] out);
  
  assign out = (sel) ? a : b;
  
endmodule
