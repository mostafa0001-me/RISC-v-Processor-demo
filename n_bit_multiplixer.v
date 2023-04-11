`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2023 01:32:30 PM
// Design Name: 
// Module Name: n_bit_multiplixer
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


module MUX #(parameter n = 32)(input[n-1:0] in1,input[n-1:0] in2, input choose, output[n-1:0] out);

assign out = choose?in2:in1;

endmodule
