`timescale 1ns/1ps

module FIFO#(
    parameter width = 32,
    parameter depth = 54,
    parameter ptr_w = 6
)
(
    clk, rstn,
    rd_en, wrt_en,
    data_in,
    data_out,
    full, empty,
    out_valid,

    almost_full,
    almost_empty
);

input clk, rstn;
input rd_en, wrt_en;
input [width-1 : 0] data_in;
output [width-1 : 0] data_out;
input full, empty;
output out_valid;
input almost_full, almost_empty;

reg full, empty, almost_full, almost_empty;
reg [width-1 : 0] sram_mem [0 : depth-1];
reg [ptr_w-1 : 0] waddr, raddr;
//data_out
assign data_out = (rd_en & !empty) ? sram_mem[raddr] : 0;
//data_in
integer i;
always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
        for(i = 0; i < depth; i=i+1)begin
            sram_mem[i] <= 'b0;
        end
    end
    else begin
        if((wrt_en & !full) || (full & wrt_en & rd_en))begin
            sram_mem[waddr] <= data_in;
        end
    end
end

//raddr
always @(posedge clk or negedge rstn) begin
    if(!rstn)begin
        raddr <= 'b0;
    end
    else begin
        if(rd_en & !empty) begin
            raddr <= raddr +'b1;
        end
    end
end
//waddr
always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        waddr <= 'b0;
    end
    else begin
        if((wrt_en & !full) || (full & wrt_en & rd_en)) begin
            waddr <= waddr + 'b1;
        end
    end
end
//full
always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        full <= 'b0;
    end
    else begin
        if((wrt_en & !rd_en) && (waddr == raddr - 'b1)) begin//0 to 1
            full <= 'b1;
        end
        else if(full & rd_en & !wrt_en) begin//1 to 0
            full <= 'b0;
        end
    end
end
//empty
always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        empty <= 'b1;
    end
    else begin
        if((rd_en & !wrt_en) && (raddr == waddr - 'b1)) begin//0 to 1
            empty <= 'b1;
        end
        else if(wrt_en & empty) begin//1 to 0
            empty <= 'b0;
        end
    end
end
//almost_full
always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        almost_full <= 'b0;
    end
    else begin
        if((wrt_en & !rd_en) && (waddr == raddr - 2'b10)) begin// 0 to 1
            almost_full <= 'b1;
        end
        else if(almost_full & rd_en & !wrt_en & (waddr == raddr - 'b1)) begin// 1 to 0
            almost_full <= 'b0;
        end
    end
end
//almost_empty
always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        almost_empty <= 'b1;
    end
    else begin
        if((rd_en & !wrt_en) && (raddr == waddr- 2'b10)) begin//0 to 1
            almost_empty <= 'b1;
        end
        else if(almost_empty & wrt_en & !rd_en & (raddr == waddr - 'b1)) begin//1 to 0
            almost_empty <= 'b0;
        end
    end
end
endmodule