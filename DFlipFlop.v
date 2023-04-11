`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2023 12:25:38 PM
// Design Name: 
// Module Name: DFlipFlop
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


module DFlipFlop
 (input clk, input rst, input D, output reg Q, input load);
 
 always @ (posedge clk or posedge rst)
 
 if (rst) 
 Q <= 1'b0;
 else if (load) 
 Q <= D;
 else 
 Q <= Q;
 
endmodule 
