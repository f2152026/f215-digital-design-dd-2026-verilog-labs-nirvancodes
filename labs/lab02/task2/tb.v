module tb;

  reg  [2:0] t_sel;
  wire [7:0] t_dout;

  lut #(
    .WIDTH(8),
    .DEPTH(8)
  ) U1 (
    .sel(t_sel),
    .dout(t_dout)
  );

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, U1);
    end
  end

  initial begin
    t_sel = 3'd0;
    #5;

    if (t_dout !== 8'd0)
      $display("FAIL: sel=%0d expected=0 got=%0d", t_sel, t_dout);
    else
      $display("PASS: sel=%0d dout=%0d", t_sel, t_dout);

    t_sel = 3'd1;
    #5;

    if (t_dout !== 8'd1)
      $display("FAIL: sel=%0d expected=1 got=%0d", t_sel, t_dout);
    else
      $display("PASS: sel=%0d dout=%0d", t_sel, t_dout);

    t_sel = 3'd2;
    #5;

    if (t_dout !== 8'd4)
      $display("FAIL: sel=%0d expected=4 got=%0d", t_sel, t_dout);
    else
      $display("PASS: sel=%0d dout=%0d", t_sel, t_dout);

    t_sel = 3'd3;
    #5;

    if (t_dout !== 8'd9)
      $display("FAIL: sel=%0d expected=9 got=%0d", t_sel, t_dout);
    else
      $display("PASS: sel=%0d dout=%0d", t_sel, t_dout);

    t_sel = 3'd4;
    #5;

    if (t_dout !== 8'd16)
      $display("FAIL: sel=%0d expected=16 got=%0d", t_sel, t_dout);
    else
      $display("PASS: sel=%0d dout=%0d", t_sel, t_dout);

    t_sel = 3'd5;
    #5;

    if (t_dout !== 8'd25)
      $display("FAIL: sel=%0d expected=25 got=%0d", t_sel, t_dout);
    else
      $display("PASS: sel=%0d dout=%0d", t_sel, t_dout);

    t_sel = 3'd6;
    #5;

    if (t_dout !== 8'd36)
      $display("FAIL: sel=%0d expected=36 got=%0d", t_sel, t_dout);
    else
      $display("PASS: sel=%0d dout=%0d", t_sel, t_dout);

    t_sel = 3'd7;
    #5;

    if (t_dout !== 8'd49)
      $display("FAIL: sel=%0d expected=49 got=%0d", t_sel, t_dout);
    else
      $display("PASS: sel=%0d dout=%0d", t_sel, t_dout);

    $finish;
  end

  initial begin
    $monitor($time,
             " sel=%b | dout=%d",
             t_sel, t_dout);
  end

endmodule
