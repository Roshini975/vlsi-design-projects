`timescale 1ns/1ps

module tb_alu;

reg [7:0] a, b;
reg [2:0] opcode;
wire [7:0] result;
wire zero_flag, carry_flag;

alu dut (
    .a(a), .b(b), .opcode(opcode),
    .result(result),
    .zero_flag(zero_flag),
    .carry_flag(carry_flag)
);

task apply_test;
    input [7:0] in_a, in_b;
    input [2:0] op;
    input [7:0] expected;
    begin
        a = in_a; b = in_b; opcode = op;
        #10;
        $display("OP=%b | A=%0d B=%0d | Result=%0d | Zero=%b Carry=%b | %s",
            op, in_a, in_b, result, zero_flag, carry_flag,
            (result == expected) ? "PASS" : "FAIL");
    end
endtask

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_alu);

    $display("===== ALU VERIFICATION START =====");

    // ADD
    apply_test(8'd10,  8'd5,   3'b000, 8'd15);
    apply_test(8'd20,  8'd8,   3'b001, 8'd12);  // SUB
    apply_test(8'hFF,  8'h0F,  3'b010, 8'h0F);  // AND
    apply_test(8'hF0,  8'h0F,  3'b011, 8'hFF);  // OR
    apply_test(8'hAA,  8'hAA,  3'b100, 8'h00);  // XOR → zero
    apply_test(8'h00,  8'h00,  3'b101, 8'hFF);  // NOT
    apply_test(8'b00001111, 8'h00, 3'b110, 8'b00011110); // LSHIFT
    apply_test(8'b11110000, 8'h00, 3'b111, 8'b01111000); // RSHIFT

    $display("===== ALU VERIFICATION DONE =====");
    $finish;
end

endmodule
