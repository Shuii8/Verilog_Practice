`timescale 1ns/1ps

module tb;
  // Entradas al DUT
  reg        in;
  reg  [1:0] state;

  // Salidas del DUT
  wire [1:0] next_state;
  wire       out;

  // Instancia del DUT
  top_module dut (
    .in(in),
    .state(state),
    .next_state(next_state),
    .out(out)
  );

  // Variables esperadas (checker)
  reg [1:0] exp_next;
  reg       exp_out;
  integer   s, i, errors;

  // VCD para ver en GTKWave
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
  end

  // Función de referencia (según la tabla del enunciado)
  task calc_expected;
    input [1:0] cur_state;
    input       cur_in;
    output [1:0] nx;
    output       o;
    begin
      // out (Moore): solo D=2'b11 produce 1
      o = (cur_state == 2'b11);

      // next_state según tabla:
      case (cur_state)
        2'b00: nx = (cur_in ? 2'b01 : 2'b00); // A: 1->B, 0->A
        2'b01: nx = (cur_in ? 2'b01 : 2'b10); // B: 1->B, 0->C
        2'b10: nx = (cur_in ? 2'b11 : 2'b00); // C: 1->D, 0->A
        2'b11: nx = (cur_in ? 2'b01 : 2'b10); // D: 1->B, 0->C
        default: nx = 2'b00;
      endcase
    end
  endtask

  // Estímulos y chequeo
  initial begin
    errors = 0;

    // Recorre todos los estados válidos y ambas entradas
    for (s = 0; s < 4; s = s + 1) begin
      state = s[1:0];
      for (i = 0; i < 2; i = i + 1) begin
        in = i[0];
        #1; // deja que el DUT calcule

        calc_expected(state, in, exp_next, exp_out);

        if (next_state !== exp_next || out !== exp_out) begin
          $display("ERROR: state=%b in=%b -> next=%b(out=%b)  esperado next=%b(out=%b)",
                   state, in, next_state, out, exp_next, exp_out);
          errors = errors + 1;
        end else begin
          $display("OK   : state=%b in=%b -> next=%b out=%b",
                   state, in, next_state, out);
        end
      end
    end

    if (errors == 0) $display("Test PASADO (sin errores).");
    else             $display("Test FALLÓ: %0d errores.", errors);
    $finish;
  end
endmodule

