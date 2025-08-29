module tb;
  
  reg  a, b;
  wire  out;
  
  ejemplo test( a, b, out);
  
  //Pruebas
  
  initial begin
    
    a = 0; b = 0;
    
    #10 a = 1'b0; b = 1'b0; 
    #10 a = 1'b0; b = 1'b1; 
    #10 a = 1'b1; b = 1'b0; 
    #10 a = 1'b1; b = 1'b1; 
    #5 $finish;
    
  end
  
  initial
    $monitor ("time:%0t, a:%b, b:%b, out:%b", $time, a, b, out);
  
endmodule
