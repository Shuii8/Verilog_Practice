
`timescale 1ns/1ps

module tb_top;

	reg [3:0] a, b;
	wire [3:0] sum;
	wire [7:0] product;

	adder dut1 (.a(a), .b(b), .y(sum));
	multiplier dut2 (.a(a), .b(b), .y(product));

	initial begin

	$dumpfile("dump.vcd");
	$dumpvars(0, tb_top);

        // Mensajes de seguimiento
    $display("Tiempo | a b | sum product");
    $monitor("%4t | %d %d | %d %d", 
              $time, tb_top.a, tb_top.b, tb_top.sum, tb_top.product);

		a = 4'd0;
		b = 4'd1;
		#10 a = 4'd1;
		b = 4'd2;
		#10 a = 4'd2;
		b = 4'd3;
		#10 $finish;
 
	end
endmodule
