module sync_fifo #(
  parameter DATA_WIDTH = 8,
  parameter DEPTH = 16
)(
  input clk, rst_n, wr_en, rd_en,
  input  [DATA_WIDTH-1:0] din,
  output reg [DATA_WIDTH-1:0] dout,
  output full, empty
);

reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
reg [$clog2(DEPTH):0] wr_ptr, rd_ptr;

wire [$clog2(DEPTH):0] count;
assign count = wr_ptr - rd_ptr;
assign full  = (count == DEPTH);
assign empty = (count == 0);

integer i;

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    wr_ptr <= 0;
    for (i=0; i<DEPTH; i=i+1) mem[i] <= 0;
  end else if (wr_en && !full) begin
    mem[wr_ptr[$clog2(DEPTH)-1:0]] <= din;
    wr_ptr <= wr_ptr + 1;
  end
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    rd_ptr <= 0;
    dout   <= 0;
  end else if (rd_en && !empty) begin
    dout   <= mem[rd_ptr[$clog2(DEPTH)-1:0]];
    rd_ptr <= rd_ptr + 1;
  end
end

endmodule
