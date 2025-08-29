
module tb;
  reg clk=0, reset=1, w=0;
  wire z;
  top_module dut(.clk(clk), .reset(reset), .w(w), .z(z));

  // reloj
  always #5 clk = ~clk;

  initial begin
    $dumpfile("tb.vcd"); $dumpvars(0,tb);
    // reset
    repeat(2) @(posedge clk);
    reset = 0;

    // A(w=1)->B(w=1)->C(w=1)->E  (z debe volverse 1 en E)
    w=1; @(posedge clk);  // A->B
    w=1; @(posedge clk);  // B->C
    w=1; @(posedge clk);  // C->E (z=1)
    // E(w=0)->D(w=1)->F (z=1), F(w=0)->D(w=0)->A (z=0)
    w=0; @(posedge clk);  // E->D
    w=1; @(posedge clk);  // D->F (z=1)
    w=0; @(posedge clk);  // F->D (z=0)
    w=0; @(posedge clk);  // D->A

    $finish;
  end
  
  always @(posedge clk) begin 
    $strobe("t=%0t state=%0d z=%0d", $time, tb.dut.state, z);
	end
endmodule
