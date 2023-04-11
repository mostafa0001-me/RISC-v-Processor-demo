`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2023 11:55:51 AM
// Design Name: 
// Module Name: Lab4_Q1
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
/*


module RCAdder
#(parameter n =8)
(
    input clk, 
    input cin, 
    input[n-1:0] a, 
    input[n-1:0] b, 
    output [n-1:0]out
);


*/


module ALU #(parameter n=32)(input clk, input cin, input [n-1:0] a,input [n-1:0] b,input [3:0]select,output zflag,output reg[n-1:0] out);
    
wire [n-1:0]temp[15:0];
wire [n-1:0]b_n;


    assign b_n = ~b;

assign temp[4'b0000] = a&b;    // and 
assign temp[4'b0001] = a|b;    // or 
RCAdder #(n)rca1(.cin(1'b0), .a(a), .b(b), .out(temp[4'b0010]) ); // add
RCAdder #(n)rca2(.cin(1'b1), .a(a), .b(b_n), .out(temp[4'b0110]) ); // sub




always@(*)
begin
    
    case(select)
        4'b0010:  begin out = temp[4'b0010]; end    // add
        4'b0110:  begin out = temp[4'b0110]; end    // sub 
        4'b0000:  begin out = temp[4'b0000]; end    // AND
        4'b0001:  begin out = temp[4'b0001]; end    // OR
        default:  begin out = 0; end              // any other 
    endcase
    
end    
     
        assign zflag = out == 0 ? 1 : 0;

endmodule
