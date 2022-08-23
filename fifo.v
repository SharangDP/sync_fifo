// Synchronous FIFO
module sync_fifo(
  input clk,
  input reset,
  input wr_en,
  input [7:0] datain,
  output full,
  
  input rd_en,
  output reg [7:0] dataout,
  output empty);
  
  parameter DEPTH = 8;
  
  reg [7:0] mem [0:DEPTH-1];
  reg [2:0] wr_ptr;
  reg [2:0] rd_ptr;
  reg [3:0] count;
  
  assign full = (count==DEPTH);
  assign empty = (count==0);
  
// Write Operations-------------------------
  always@(posedge clk, negedge reset) begin
    if(!reset)
      wr_ptr <=3'd0;
    else begin
      if(wr_en) begin
        mem[wr_ptr] <= datain;
        wr_ptr <= wr_ptr+1;
      end
    end
  end
  
// Read Operations-------------------------
  always@(posedge clk, negedge reset) begin
    if(!reset)
      rd_ptr <=3'd0;
    else begin
      if(wr_en) begin
        dataout <= mem[rd_ptr];
        rd_ptr <= rd_ptr+1;
      end
    end
  end
  
// Count handling----------------------------
  always@(posedge clk, negedge reset) begin
    if(!reset)
      count <=4'd0;
    else begin
      case({wr_en,rd_en})
        2'b10: count <= count+1;
        2'b01: count <= count-1;
        default: count <= count;
      endcase
    end
  end
  
endmodule