// tb.v
// Self-checking testbench for comp2.

module tb;

  reg  [1:0] t_a, t_b;
  wire t_gt, t_lt, t_eq;

  reg exp_gt, exp_lt, exp_eq;

  integer a_i, b_i;
  integer errors;
  integer total;

  comp2 DUT (
    .A  (t_a),
    .B  (t_b),
    .GT (t_gt),
    .LT (t_lt),
    .EQ (t_eq)
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

    for (a_i = 0; a_i < 4; a_i = a_i + 1) begin
      for (b_i = 0; b_i < 4; b_i = b_i + 1) begin

        t_a = a_i;
        t_b = b_i;

        #1;

        // Calculate expected values independently.
        exp_gt = (a_i > b_i);
        exp_lt = (a_i < b_i);
        exp_eq = (a_i == b_i);

        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq,
                   exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end

        total = total + 1;
      end
    end

    $display("SUMMARY: %0d passed out of %0d total combinations.",
             total-errors, total);

    $finish;
  end

  initial
    $monitor($time, " A=%b B=%b | GT=%b LT=%b EQ=%b",
             t_a, t_b, t_gt, t_lt, t_eq);

endmodule