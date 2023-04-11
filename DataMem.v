`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2023 09:57:26 AM
// Design Name: 
// Module Name: DataMem
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


module DataMem(input clk, input MemRead, input MemWrite,input [5:0] addr, input [31:0] data_in, output [31:0] data_out);
    reg [31:0] mem [0:63];
    assign data_out = MemRead?mem[addr]:32'b0;
    always @(posedge(clk)) begin
        if(MemWrite)
            mem[addr] = data_in;
    end 
    initial begin
        mem[0]=32'd17;
        mem[1]=32'd9;
        mem[2]=32'd25;
    end 


endmodule