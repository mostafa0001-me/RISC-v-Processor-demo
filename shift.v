`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2023 11:43:39 AM
// Design Name: 
// Module Name: shift
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


module shift #(parameter n = 32)(input[n-1:0] A, output[n-1:0] B);

assign B = {A[n-2:0], 1'b0};

endmodule
