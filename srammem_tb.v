`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/13 09:08:32
// Design Name: 
// Module Name: srammem_tb
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


module srammem_tb();
reg clk, rstn;
reg wen, ren;
reg [5 : 0] waddr, raddr;
reg [31 : 0] data_in;
wire [31 : 0]data_out;
wire out_valid;

always #5 clk = ~clk;

initial begin
    clk = 0;
    rstn = 0;
    #20
    rstn = 1;
    wen = 1;
    ren = 0;
    waddr = 'd1;
    raddr = 'd0;
    data_in = 'd1;
    #10
    wen = 1;
    ren = 0;
    waddr = 'd2;
    raddr = 'd0;
    data_in = 'd2;
    #10
    wen = 1;
    ren = 1;
    waddr = 'd3;
    raddr = 'd3;
    data_in = 'd3;
    #10
    wen = 1;
    ren = 1;
    waddr = 'd4;
    raddr = 'd1;
    data_in = 'd4;

end

sram sram0 (
    .clk(clk),
    .rstn(rstn),
    .wen(wen),
    .ren(ren),
    .waddr(waddr),
    .raddr(raddr),
    .data_in(data_in),
    .data_out(data_out),
    .out_valid(out_valid)
);
endmodule
