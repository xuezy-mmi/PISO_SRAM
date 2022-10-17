`timescale 1ns/1ps

module PISO_SRAM#(
    parameter width = 32,
    parameter depth = 64,
    parameter ptr_w = 6
)
(
    clk, rstn,
    rd_en, wrt_en,
    data_in,
    data_out,
    full, empty,
    out_valid,
    read_ready
);
input clk, rstn;
input rd_en, wrt_en;
input [width-1 : 0] data_in;
output data_out;
output full, empty;
output out_valid;
output read_ready;

//reg full, empty;
//reg [ptr_w-1 : 0] waddr, raddr;

//reg is_reading;

wire [width-1 : 0] trans_data;
wire trans_valid;

FIFO fifo0(
    .clk(clk), 
    .rstn(rstn),
    .rd_en(rd_en), 
    .wrt_en(wrt_en),
    .data_in(data_in),
    .read_ready(read_ready),
    .data_out(trans_data),
    .full(full), 
    .empty(empty),
    .out_valid(trans_valid),
    .almost_full(),
    .almost_empty());

serial_out so1(
    .clk(clk), .rstn(rstn),
    .rd_en(trans_valid),
    .data_in(trans_data),
    .data_out(data_out),
    .read_ready(read_ready),
    .data_valid(out_valid)
);


endmodule