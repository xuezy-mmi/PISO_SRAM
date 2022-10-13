`timescale 1ns / 1ps

module sram #(
    parameter width = 32,
    parameter depth = 64,
    parameter ptr_w = 6
)
(
    clk,
    rstn,
    wen,
    ren,
    waddr,
    raddr,
    data_in,
    data_out,
    out_valid
);
input clk;
input rstn;
input wen;
input ren;
input [ptr_w-1 : 0] waddr;
input [ptr_w-1 : 0] raddr;
input [width-1 : 0] data_in;
output [width-1 : 0] data_out;
output out_valid;

reg [width-1 : 0] sram_mem [0 : depth-1];
reg [width-1 : 0] reg_out;
reg out_valid;
integer i;
always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        for(i = 0; i < depth; i = i+1)
            sram_mem[i] <= 0;
        reg_out <= 0;
        out_valid <= 0;
    end
    else begin
        if(wen && ren) begin
            if(waddr == raddr) begin
                reg_out <= data_in;
                out_valid <= 'b1;
            end
            else begin
                sram_mem[waddr] <= data_in;
                reg_out <= sram_mem[raddr];
                out_valid <= 'b1;
                sram_mem[raddr] <= 0;
            end
        end
        else if(wen && !ren) begin
            sram_mem[waddr] <= data_in;
        end
        else if(ren && !wen) begin
            reg_out <= sram_mem[raddr];
            out_valid <= 'b1;
            sram_mem[raddr] <= 0;
        end
        else begin
            out_valid <= 'b0;
        end
    end
end

assign data_out = reg_out;
endmodule