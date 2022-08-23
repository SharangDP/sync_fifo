//Testbench
`timescale 1ns/1ps

`define clk_period 10

module sync_fifo_tb();
  
  reg clk,reset;
  reg wr_en,rd_en;
  reg [7:0] datain;
  
  wire [7:0] dataout;
  wire full,empty;
  
  sync_fifo SYNFIF(
    .clk(clk),
    .reset(reset),
    .wr_en(wr_en),
    .datain(datain),
    .full(full),
    .rd_en(rd_en),
    .dataout(dataout),
    .empty(empty));
  
  initial clk = 1'b1;
  always #(`clk_period/2) clk = ~clk;
  
  integer i;
  
  initial begin
    reset = 1'b0;
    wr_en = 1'b0;
    rd_en = 1'b0;
    datain = 8'b0;
    
    #(`clk_period);
    reset = 1'b0;
    #(`clk_period);
    reset = 1'b1;
    
    wr_en = 1'b1;
    rd_en = 1'b0;
    
    for(i=0;i<8;i=i+1) begin
      datain = i;
      #(`clk_period);
    end
    
    wr_en = 1'b0;
    rd_en = 1'b1;
    
    for(i=0;i<8;i=i+1) begin
      #(`clk_period);
    end
    
    wr_en = 1'b1;
    rd_en = 1'b0;
    
    for(i=0;i<8;i=i+1) begin
      datain = i;
      #(`clk_period);
    end
    
    #(`clk_period);
    #(`clk_period);
    #(`clk_period);
    
    $finish;
  end
endmodule