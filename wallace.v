
module full_adder(
    input a, b, cin,
    output sum, cout
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module half_adder(
    input a, b,
    output sum, cout
);
    assign sum  = a ^ b;
    assign cout = a & b;
endmodule

module wallace_multiplier_4x4(
    input  [3:0] A,
    input  [3:0] B,
    output [7:0] P
);

    wire [3:0] pp0, pp1, pp2, pp3;

    // Partial product generation
    assign pp0 = A & {4{B[0]}};
    assign pp1 = A & {4{B[1]}};
    assign pp2 = A & {4{B[2]}};
    assign pp3 = A & {4{B[3]}};

    wire s1, c1;
    wire s2, c2;
    wire s3, c3;
    wire s4, c4;
    wire s5, c5;
    wire s6, c6;

    // Stage 1
    full_adder FA1(pp0[1], pp1[0], 1'b0, s1, c1);
    full_adder FA2(pp0[2], pp1[1], pp2[0], s2, c2);
    full_adder FA3(pp0[3], pp1[2], pp2[1], s3, c3);
    half_adder HA1(pp1[3], pp2[2], s4, c4);

    // Stage 2
    full_adder FA4(s2, pp3[0], c1, s5, c5);
    full_adder FA5(s3, pp3[1], c2, s6, c6);

    // Final addition
    wire [7:0] row1, row2;

    assign row1 = {
        pp3[3], s4, s6, s5, s1, pp0[0], 1'b0, 1'b0
    };

    assign row2 = {
        1'b0, c6, c5, c4, c3, 1'b0, 1'b0, 1'b0
    };

    assign P = row1 + row2;

endmodule
