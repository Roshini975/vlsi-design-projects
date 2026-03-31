module alu(
  input [7:0] a, b,
  input [2:0] opcode,
  output reg [7:0] result,
  output reg zero_flag, carry_flag
);
reg [8:0] temp;
always @(*) begin
  carry_flag = 0;
  case(opcode)
    3'b000: begin temp=a+b; result=temp[7:0]; carry_flag=temp[8]; end
    3'b001: begin temp=a-b; result=temp[7:0]; carry_flag=temp[8]; end
    3'b010: result = a & b;
    3'b011: result = a | b;
    3'b100: result = a ^ b;
    3'b101: result = ~a;
    3'b110: result = a << 1;
    3'b111: result = a >> 1;
    default: result = 8'b0;
  endcase
  zero_flag = (result == 8'b0);
end
endmodule
