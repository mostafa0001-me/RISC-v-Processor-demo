`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2023 12:25:04 PM
// Design Name: 
// Module Name: n_bit_register
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

// (input clk, input rst, input D, output reg Q);
module Register#(parameter n=8)(
    input clk, 
    input rst,
    input load, 
    input[n-1:0] in, 
    output reg[n-1:0] out

    );

    always@ (posedge clk, posedge rst)
        begin
            if(rst)
                out = 0;
            else
                if(load)
                    out = in;
                else
                    out = out;
        end
    
endmodule
