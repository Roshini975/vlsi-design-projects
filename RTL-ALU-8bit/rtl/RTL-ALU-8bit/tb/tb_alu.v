`timescale 1ns/1ps
module tb_alu;
reg [7:0] a, b;
reg [2:0] opcode;
wire [7:0] result;
wire zero_flag, carry_flag;

alu dut(.a(a),.b(b),.opcode(opcode),
        .result(result),.zero_flag(zero_flag),.carry_flag(carry_flag));

initial begin
  $dumpfile("dump.vcd"); $dumpvars(0,tb_alu);
  a=10; b=5;  opcode=3'b000; #10;
  $display("ADD: %0d+%0d=%0d (expect 15) %s",a,b,result,(result==15)?"PASS":"FAIL");
  a=20; b=8;  opcode=3'b001; #10;
  $display("SUB: %0d-%0d=%0d (expect 12) %s",a,b,result,(result==12)?"PASS":"FAIL");
  a=8'hFF; b=8'h0F; opcode=3'b010; #10;
  $display("AND: %0d (expect 15) %s",result,(result==15)?"PASS":"FAIL");
  a=8'hF0; b=8'h0F; opcode=3'b011; #10;
  $display("OR:  %0d (expect 255) %s",result,(result==255)?"PASS":"FAIL");
  a=8'hAA; b=8'hAA; opcode=3'b100; #10;
  $display("XOR: %0d (expect 0, zero=%0b) %s",result,zero_flag,(result==0)?"PASS":"FAIL");
  $display("ALL TESTS DONE"); $finish;
end
endmodule
