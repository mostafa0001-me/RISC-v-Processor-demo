`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2023 09:53:32 PM
// Design Name: 
// Module Name: Processor_tb
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


module Processor_tb;

//input clk, input reset, input [1:0] LedSel, input [3:0] ssdSel,
  //  input ssdClk, output reg[15:0] Leds, output reg[12:0] ssd

reg clk;
reg reset;
reg[1:0] LedSel;
reg[3:0] ssdSel;
wire ssdClk;
wire[15:0] Leds;
wire[12:0] ssd;
//wire[6:0] LED_out;
//wire[3:0] Anode;

Processor init(clk, reset, LedSel, ssdSel, ssdClk, Leds, ssd);

   parameter PERIOD = 20;

   always begin
      clk = 1'b0;
      #(PERIOD/2) clk = 1'b1;
      #(PERIOD/2);
   end
				
				
initial begin
    clk = 0;
    reset = 1;
    #10
    reset = 0;
//    clk = 0;
//    #10
//    clk = 0;
//    LedSel = 2'b00;
//    ssdSel = 4'b0000;
//    #10
//    LedSel = 2'b01;
//    ssdSel = 4'b0001;
//    #10
//    LedSel = 2'b10;
//    ssdSel = 4'b0010;
//    #10
//    ssdSel = 4'b0011;
//    #10
//    ssdSel = 4'b0100;
//    #10
//    ssdSel = 4'b0101;
//    #10
//    ssdSel = 4'b0110;
//    #10
//    ssdSel = 4'b0111;
//    #10
//    ssdSel = 4'b1000;
//    #10
//    ssdSel = 4'b1001;
//    #10
//    ssdSel = 4'b1010;
//    #10
//    ssdSel = 4'b1011;
    #1000;
    $finish;
end


endmodule
