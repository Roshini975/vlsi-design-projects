`timescale 1ns/1ps
module tb_fifo;

parameter DATA_WIDTH = 8;
parameter DEPTH = 16;

reg clk, rst_n, wr_en, rd_en;
reg  [DATA_WIDTH-1:0] din;
wire [DATA_WIDTH-1:0] dout;
wire full, empty;

sync_fifo #(.DATA_WIDTH(DATA_WIDTH),.DEPTH(DEPTH)) dut (
  .clk(clk),.rst_n(rst_n),
  .wr_en(wr_en),.rd_en(rd_en),
  .din(din),.dout(dout),
  .full(full),.empty(empty)
);

always #5 clk = ~clk;

integer i;

initial begin
  $dumpfile("dump.vcd");
  $dumpvars(0, tb_fifo);

  clk=0; rst_n=0; wr_en=0; rd_en=0; din=0;
  #20; rst_n=1;

  // TEST 1: Write 3 values
  $display("=== TEST 1: Normal Write ===");
  @(posedge clk); #1; wr_en=1; din=8'd10;
  @(posedge clk); #1; din=8'd20;
  @(posedge clk); #1; din=8'd30;
  @(posedge clk); #1; wr_en=0;
  $display("After 3 writes - full=%b empty=%b", full, empty);

  // TEST 2: Read 3 values
  $display("=== TEST 2: Normal Read ===");
  @(posedge clk); #1; rd_en=1;
  @(posedge clk); #1;
  $display("Read1: dout=%0d (expect 10) %s", dout, (dout==10)?"PASS":"FAIL");
  @(posedge clk); #1;
  $display("Read2: dout=%0d (expect 20) %s", dout, (dout==20)?"PASS":"FAIL");
  @(posedge clk); #1;
  $display("Read3: dout=%0d (expect 30) %s", dout, (dout==30)?"PASS":"FAIL");
  @(posedge clk); #1; rd_en=0;

  // TEST 3: Fill to FULL
  $display("=== TEST 3: Fill to FULL ===");
  rst_n=0; #20; rst_n=1; #10;
  @(posedge clk); #1; wr_en=1;
  for(i=0; i<DEPTH; i=i+1) begin
    din = i*3;
    @(posedge clk); #1;
  end
  wr_en=0;
  #1; // let signals settle
  $display("Full flag = %b (expect 1)", full);

  // TEST 4: Overflow protection
  $display("=== TEST 4: Overflow protection ===");
  @(posedge clk); #1; wr_en=1; din=8'hFF;
  @(posedge clk); #1; wr_en=0;
  $display("Still full = %b (expect 1)", full);

  // TEST 5: Drain to EMPTY
  $display("=== TEST 5: Drain to EMPTY ===");
  @(posedge clk); #1; rd_en=1;
  for(i=0; i<DEPTH; i=i+1) begin
    @(posedge clk); #1;
  end
  rd_en=0;
  #1;
  $display("Empty flag = %b (expect 1)", empty);

  // TEST 6: Underflow protection
  $display("=== TEST 6: Underflow protection ===");
  @(posedge clk); #1; rd_en=1;
  @(posedge clk); #1; rd_en=0;
  #1;
  $display("Still empty = %b (expect 1)", empty);

  $display("=== ALL FIFO TESTS DONE ===");
  $finish;
end

endmodule
