`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2023 11:55:33 AM
// Design Name: 
// Module Name: control_unit
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


module control_unit(input[31:0] instruction, output reg branch, memread, memtoreg, memwrite, alusrc, regwrite, output reg[1:0] aluop);

    always @(instruction) begin
        case(instruction[6:2])
            5'b01100: begin
                branch = 1'b0; memread = 1'b0; memtoreg = 1'b0; aluop = 2'b10; memwrite = 1'b0; alusrc = 1'b0; regwrite = 1'b1; 
            end
            5'b00000: begin
                branch = 1'b0; memread = 1'b1; memtoreg = 1'b1; aluop = 2'b00; memwrite = 1'b0; alusrc = 1'b1; regwrite = 1'b1; 
            end
            5'b01000: begin
                branch = 1'b0; memread = 1'b0; memtoreg = 1'b0; aluop = 2'b00; memwrite = 1'b1; alusrc = 1'b1; regwrite = 1'b0; 
            end
            5'b11000: begin
                branch = 1'b1; memread = 1'b0; memtoreg = 1'b0; aluop = 2'b01; memwrite = 1'b0; alusrc = 1'b0; regwrite = 1'b0; 
            end
            default: begin branch = 1'b0; memread = 1'b0; memtoreg = 1'b0; aluop = 2'b10; memwrite = 1'b0; alusrc = 1'b0; regwrite = 1'b1; end
        endcase
    end
endmodule
