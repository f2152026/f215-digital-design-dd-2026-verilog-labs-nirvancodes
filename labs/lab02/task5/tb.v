// tb.v
// Self-checking testbench for alu.

module tb;

  reg [3:0] t_a, t_b;
  reg       t_op;
  wire [3:0] t_result;

  reg [3:0] expected;

  integer a_i, b_i, op_i;
  integer errors;
  integer total;

  alu DUT (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;
    total = 0;

    // Test both operations for every operand combination.
    for (op_i = 0; op_i < 2; op_i = op_i + 1) begin
      for (a_i = 0; a_i < 16; a_i = a_i + 1) begin
        for (b_i = 0; b_i < 16; b_i = b_i + 1) begin

          t_op = op_i;
          t_a = a_i;
          t_b = b_i;

          #1;

          if (t_op == 0)
            expected = a_i + b_i;
          else
            expected = a_i - b_i;

          if (t_result !== expected) begin
            $display("FAIL at time %0t: op=%b a=%h b=%h got=%h expected=%h",
                     $time, t_op, t_a, t_b, t_result, expected);
            errors = errors + 1;
          end

          total = total + 1;
        end
      end
    end

    $display("SUMMARY: %0d passed out of %0d total tests.",
             total-errors, total);

    $finish;
  end

  initial
    $monitor($time, " op=%b a=%h b=%h | result=%h",
             t_op, t_a, t_b, t_result);

endmodule