`timescale 1ns/1ps

module serial_out#(
    parameter width = 32,
    parameter count_w = 5
)
(
    clk, rstn,
    rd_en,
    data_in,
    data_out,
    read_ready,
    data_valid
);

input clk ,rstn;
input [width-1 : 0] data_in;
input rd_en;
output data_out;
output read_ready;
output data_valid;
reg [width-1 : 0] data_reg;
reg [count_w-1 : 0] count;
reg data_valid;
reg read_ready;
integer i;
always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
        count <= 'b0;
        data_reg <= 'b0;
        data_valid <= 'b0;
        read_ready <= 'b1;
    end
    else begin
        if(count == 'd31) begin
            data_valid <= 'b0;
            read_ready <= 'b1;
            count <= 'b0;
        end
        else begin
            if(rd_en & read_ready) begin
                data_valid <= 'b1;
                read_ready <= 'b0;
                data_reg <= data_in;
                count <= 'b0;
            end
            if(data_valid) begin
                count <= count + 'b1;
                data_reg <= data_reg >> 1;
            end
        end
    end
end
assign data_out = data_valid ? data_reg[0] : 0;
endmodule