module tb;
  
  reg [3:0] a, b;
  wire [7:0] sum, multi;
  
  
  top dut(a, b, sum, multi);
  
  initial begin
    
    a = 4'd0; b = 4'd0;
    
    #10 a = 4'd1; b = 4'd2;
    #10 a = 4'd2; b = 4'd3;
    
    #5 $finish;
    
    
  end
  
  initial
    $monitor ("tiempo:  %0t, a:%d, b:%d, sum:%d, multi:%d", $time, a, b, sum, multi);
  
endmodule
