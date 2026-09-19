// cla64_hier.v
// BONUS -- open-ended. No detailed scaffold is provided; this is meant to
// be a genuine design exercise. Not required for lab submission.
//
// You will likely need to modify cla4.v (or add signals alongside it) so
// that block-generate/block-propagate summaries of its own Gi, Pi signals
// are exposed as outputs, since the second-level lookahead unit below
// needs them. As with every module in this lab from Task 2 onward, every
// gate/assign you add should carry an explicit delay.
//
// Starting point (from Tutorial 3, Q4(d)):
//   - Reuse 16 four-bit CLA blocks (your cla4.v) -- their internal logic
//     doesn't change.
//   - For each block k, define:
//       Gblk_k = "this block produces a carry regardless of its incoming
//                 carry" -- a Boolean function of that block's own 4
//                 bit-level Gi, Pi signals.
//       Pblk_k = "an incoming carry sails straight through this whole
//                 block" -- likewise a function of its own Gi, Pi.
//   - Build a second-level lookahead unit -- structurally identical to
//     cla4.v, just one level up -- that computes each block's carry-in
//     directly from Gblk_0..Gblk_15, Pblk_0..Pblk_15, and cin, instead of
//     rippling block to block.
//
// To test this, wire it into dut.v as a fourth option (copy the pattern
// used for the other three) and run it through the same tb.v. Compare
// your final delay to cla64_blocked.v from Task 4.

module cla64_hier(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  // TODO: your hierarchical design goes here.
  wire [15:0] Pblk, Gblk;
  wire [16:0] C;
  assign C[0] = cin;

  cla4 block0 (
    .a(a[3:0]),
    .b(b[3:0]),
    .cin(C[0]),
    .sum(sum[3:0]),
    .cout(),
    .P(Pblk[0]),
    .G(Gblk[0])
  );

  cla4 block1 (
    .a(a[7:4]),
    .b(b[7:4]),
    .cin(C[1]),
    .sum(sum[7:4]),
    .cout(),
    .P(Pblk[1]),
    .G(Gblk[1])
  );

  cla4 block2 (
    .a(a[11:8]),
    .b(b[11:8]),
    .cin(C[2]),
    .sum(sum[11:8]),
    .cout(),
    .P(Pblk[2]),
    .G(Gblk[2])
  );

  cla4 block3 (
    .a(a[15:12]),
    .b(b[15:12]),
    .cin(C[3]),
    .sum(sum[15:12]),
    .cout(),
    .P(Pblk[3]),
    .G(Gblk[3])
  );

  cla4 block4 (
    .a(a[19:16]),
    .b(b[19:16]),
    .cin(C[4]),
    .sum(sum[19:16]),
    .cout(),
    .P(Pblk[4]),
    .G(Gblk[4])
  );

  cla4 block5 (
    .a(a[23:20]),
    .b(b[23:20]),
    .cin(C[5]),
    .sum(sum[23:20]),
    .cout(),
    .P(Pblk[5]),
    .G(Gblk[5])
  );

  cla4 block6 (
    .a(a[27:24]),
    .b(b[27:24]),
    .cin(C[6]),
    .sum(sum[27:24]),
    .cout(),
    .P(Pblk[6]),
    .G(Gblk[6])
  );

  cla4 block7 (
    .a(a[31:28]),
    .b(b[31:28]),
    .cin(C[7]),
    .sum(sum[31:28]),
    .cout(),
    .P(Pblk[7]),
    .G(Gblk[7])
  );

  cla4 block8 (
    .a(a[35:32]),
    .b(b[35:32]),
    .cin(C[8]),
    .sum(sum[35:32]),
    .cout(),
    .P(Pblk[8]),
    .G(Gblk[8])
  );

  cla4 block9 (
    .a(a[39:36]),
    .b(b[39:36]),
    .cin(C[9]),
    .sum(sum[39:36]),
    .cout(),
    .P(Pblk[9]),
    .G(Gblk[9])
  );

  cla4 block10 (
    .a(a[43:40]),
    .b(b[43:40]),
    .cin(C[10]),
    .sum(sum[43:40]),
    .cout(),
    .P(Pblk[10]),
    .G(Gblk[10])
  );

  cla4 block11 (
    .a(a[47:44]),
    .b(b[47:44]),
    .cin(C[11]),
    .sum(sum[47:44]),
    .cout(),
    .P(Pblk[11]),
    .G(Gblk[11])
  );

  cla4 block12 (
    .a(a[51:48]),
    .b(b[51:48]),
    .cin(C[12]),
    .sum(sum[51:48]),
    .cout(),
    .P(Pblk[12]),
    .G(Gblk[12])
  );

  cla4 block13 (
    .a(a[55:52]),
    .b(b[55:52]),
    .cin(C[13]),
    .sum(sum[55:52]),
    .cout(),
    .P(Pblk[13]),
    .G(Gblk[13])
  );

  cla4 block14 (
    .a(a[59:56]),
    .b(b[59:56]),
    .cin(C[14]),
    .sum(sum[59:56]),
    .cout(),
    .P(Pblk[14]),
    .G(Gblk[14])
  );

  cla4 block15 (
    .a(a[63:60]),
    .b(b[63:60]),
    .cin(C[15]),
    .sum(sum[63:60]),
    .cout(),
    .P(Pblk[15]),
    .G(Gblk[15])
  );

  assign #(2) C[1] =
      Gblk[0] |
      (Pblk[0] & cin);
  assign #(2) C[2] =
      Gblk[1] |
      (Pblk[1] & Gblk[0]) |
      (Pblk[1] & Pblk[0] & cin);
  assign #(2) C[3] =
      Gblk[2] |
      (Pblk[2] & Gblk[1]) |
      (Pblk[2] & Pblk[1] & Gblk[0]) |
      (Pblk[2] & Pblk[1] & Pblk[0] & cin);
  assign #(2) C[4] =
      Gblk[3] |
      (Pblk[3] & Gblk[2]) |
      (Pblk[3] & Pblk[2] & Gblk[1]) |
      (Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0]) |
      (Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);
  assign #(2) C[5] =
      Gblk[4] |
      (Pblk[4] & Gblk[3]) |
      (Pblk[4] & Pblk[3] & Gblk[2]) |
      (Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1]) |
      (Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0]) |
      (Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);
  assign #(2) C[6] =
      Gblk[5] |
      (Pblk[5] & Gblk[4]) |
      (Pblk[5] & Pblk[4] & Gblk[3]) |
      (Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2]) |
      (Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1]) |
      (Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0]) |
      (Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);
  assign #(2) C[7] =
      Gblk[6] |
      (Pblk[6] & Gblk[5]) |
      (Pblk[6] & Pblk[5] & Gblk[4]) |
      (Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3]) |
      (Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2]) |
      (Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1]) |
      (Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0]) |
      (Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);
  assign #(2) C[8] =
      Gblk[7] |
      (Pblk[7] & Gblk[6]) |
      (Pblk[7] & Pblk[6] & Gblk[5]) |
      (Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4]) |
      (Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3]) |
      (Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2]) |
      (Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1]) |
      (Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0]) |
      (Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);
  assign #(2) C[9] =
      Gblk[8] |
      (Pblk[8] & Gblk[7]) |
      (Pblk[8] & Pblk[7] & Gblk[6]) |
      (Pblk[8] & Pblk[7] & Pblk[6] & Gblk[5]) |
      (Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4]) |
      (Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3]) |
      (Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2]) |
      (Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1]) |
      (Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0]) |
      (Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);
  assign #(2) C[10] =
      Gblk[9] |
      (Pblk[9] & Gblk[8]) |
      (Pblk[9] & Pblk[8] & Gblk[7]) |
      (Pblk[9] & Pblk[8] & Pblk[7] & Gblk[6]) |
      (Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Gblk[5]) |
      (Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4]) |
      (Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3]) |
      (Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2]) |
      (Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1]) |
      (Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0]) |
      (Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);
  assign #(2) C[11] =
      Gblk[10] |
      (Pblk[10] & Gblk[9]) |
      (Pblk[10] & Pblk[9] & Gblk[8]) |
      (Pblk[10] & Pblk[9] & Pblk[8] & Gblk[7]) |
      (Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Gblk[6]) |
      (Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Gblk[5]) |
      (Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4]) |
      (Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3]) |
      (Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2]) |
      (Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1]) |
      (Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0]) |
      (Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);
  assign #(2) C[12] =
      Gblk[11] |
      (Pblk[11] & Gblk[10]) |
      (Pblk[11] & Pblk[10] & Gblk[9]) |
      (Pblk[11] & Pblk[10] & Pblk[9] & Gblk[8]) |
      (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Gblk[7]) |
      (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Gblk[6]) |
      (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Gblk[5]) |
      (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4]) |
      (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3]) |
      (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2]) |
      (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1]) |
      (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0]) |
      (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);
  assign #(2) C[13] =
      Gblk[12] |
      (Pblk[12] & Gblk[11]) |
      (Pblk[12] & Pblk[11] & Gblk[10]) |
      (Pblk[12] & Pblk[11] & Pblk[10] & Gblk[9]) |
      (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Gblk[8]) |
      (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Gblk[7]) |
      (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Gblk[6]) |
      (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Gblk[5]) |
      (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4]) |
      (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3]) |
      (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2]) |
      (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1]) |
      (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0]) |
      (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);
  assign #(2) C[14] =
      Gblk[13] |
      (Pblk[13] & Gblk[12]) |
      (Pblk[13] & Pblk[12] & Gblk[11]) |
      (Pblk[13] & Pblk[12] & Pblk[11] & Gblk[10]) |
      (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Gblk[9]) |
      (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Gblk[8]) |
      (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Gblk[7]) |
      (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Gblk[6]) |
      (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Gblk[5]) |
      (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4]) |
      (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3]) |
      (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2]) |
      (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1]) |
      (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0]) |
      (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);
  assign #(2) C[15] =
      Gblk[14] |
      (Pblk[14] & Gblk[13]) |
      (Pblk[14] & Pblk[13] & Gblk[12]) |
      (Pblk[14] & Pblk[13] & Pblk[12] & Gblk[11]) |
      (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Gblk[10]) |
      (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Gblk[9]) |
      (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Gblk[8]) |
      (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Gblk[7]) |
      (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Gblk[6]) |
      (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Gblk[5]) |
      (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4]) |
      (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3]) |
      (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2]) |
      (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1]) |
      (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0]) |
      (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);
  assign #(2) C[16] =
      Gblk[15] |
      (Pblk[15] & Gblk[14]) |
      (Pblk[15] & Pblk[14] & Gblk[13]) |
      (Pblk[15] & Pblk[14] & Pblk[13] & Gblk[12]) |
      (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Gblk[11]) |
      (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Gblk[10]) |
      (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Gblk[9]) |
      (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Gblk[8]) |
      (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Gblk[7]) |
      (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Gblk[6]) |
      (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Gblk[5]) |
      (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4]) |
      (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3]) |
      (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2]) |
      (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1]) |
      (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0]) |
      (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);

  assign cout = C[16];
endmodule
