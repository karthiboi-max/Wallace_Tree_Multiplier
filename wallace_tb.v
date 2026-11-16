

module tb_wallace_multiplier;

    reg [3:0] A, B;
    wire [7:0] P;

    integer i, j;
    integer errors;

    wallace_multiplier_4x4 DUT (
        .A(A),
        .B(B),
        .P(P)
    );

    initial begin

        errors = 0;

        $display("==================================");
        $display(" 4x4 WALLACE TREE MULTIPLIER TEST ");
        $display("==================================");

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin

                A = i;
                B = j;

                #10;

                if (P !== (A * B)) begin
                    $display(
                        "FAIL: A=%d B=%d P=%d Expected=%d",
                        A, B, P, A*B
                    );
                    errors = errors + 1;
                end
                else begin
                    $display(
                        "PASS: A=%d B=%d P=%d",
                        A, B, P
                    );
                end

            end
        end

        $display("----------------------------------");
        $display("Total test cases = 256");
        $display("Total errors = %0d", errors);

        if (errors == 0)
            $display("ALL TEST CASES PASSED!");
        else
            $display("SOME TEST CASES FAILED!");

        $finish;
    end

endmodule
