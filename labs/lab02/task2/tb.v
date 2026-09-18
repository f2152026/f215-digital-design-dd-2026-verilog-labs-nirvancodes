// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
  reg  [2:0] t_sel;
  wire [7:0] t_dout;

  // TODO: instantiate DUT here
  lut #(.WIDTH(8), .DEPTH(8)) DUT (
    .sel  (t_sel),
    .dout (t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // TODO: apply different input combinations

    for (t_sel = 0; t_sel < 8; t_sel = t_sel + 1) begin
      #5;

      if (t_dout !== (t_sel * t_sel)) begin
        $display("FAIL: sel=%0d got=%0d expected=%0d",
                 t_sel, t_dout, t_sel*t_sel);
      end
    end

    $finish;

  end

  initial
    $monitor($time, " sel=%0d | dout=%0d", t_sel, t_dout);

endmodule