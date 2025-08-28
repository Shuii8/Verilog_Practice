module tb;
 
  reg [7:0] in;
  wire [3:0] hi;
  wire [3:0] lo;
  wire [7:0] vec;
  
  ejercicio1 test(in, hi, lo, vec);
  
  //Pruebas
  
  initial begin
    
    in = 8'd0; 
     
    #10 in = 8'b11100111;
    #5 $finish;
    
  end
  
  initial
    $monitor ("time:%0t, in:%b, hi:%b, lo:%b, vec:%b", $time, in, hi, lo, vec);
  
endmodule
