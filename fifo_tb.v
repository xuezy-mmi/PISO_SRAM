`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/14 16:06:27
// Design Name: 
// Module Name: fifo_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo_tb();

reg clk, rstn;
reg rd_en, wrt_en;
reg [31 : 0] data_in;
wire [31 : 0] data_out;
wire full, empty, almost_full, almost_empty;
wire out_valid;

always #5 clk = ~clk;

initial begin
clk = 0;
rstn = 0;
#20 rstn = 1;

rd_en = 1;
wrt_en = 0;
data_in = 0;
#10
rd_en = 0;
wrt_en = 1;
data_in = 'd1;
#10
rd_en = 0;
wrt_en = 1;
data_in = 'd2;
#10
rd_en = 0;
wrt_en = 1;
data_in = 'd3;
#10
rd_en = 1;
wrt_en = 1;
data_in = 'd4;
#10
rd_en = 1;
wrt_en = 0;
data_in = 'd5;
#10
rd_en = 1;
wrt_en = 0;
data_in = 0;
#10
rd_en = 1;
wrt_en = 0;
data_in = 0;
#10
rd_en = 1;
wrt_en = 1;
data_in = 'd10;
#10
rd_en = 1;
wrt_en = 1;
data_in = 'd11;



end

FIFO fifo0(
    .clk(clk), 
    .rstn(rstn),
    .rd_en(rd_en), 
    .wrt_en(wrt_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full), 
    .empty(empty),
    .out_valid(out_valid),
    .almost_full(almost_full),
    .almost_empty(almost_empty));
endmodule
