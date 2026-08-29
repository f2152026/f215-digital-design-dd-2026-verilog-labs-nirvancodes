module FA_Gate(
  input a,
  input b,
  input cin,
  output sum,
  output cout
);

  wire ps, pc1, pc2;

  xor #(1) (ps, a, b);
  and #(1) (pc1, a, b);
  xor #(1) (sum, cin, ps);
  and #(1) (pc2, cin, ps);
  or  #(1) (cout, pc1, pc2);

endmodule
