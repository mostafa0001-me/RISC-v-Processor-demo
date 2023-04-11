`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2023 11:55:33 AM
// Design Name: 
// Module Name: registerfile
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


module registerfile#(parameter n = 32)(input write, input[n-1:0] write_data, input[4:0] write_address, input[4:0] read_address1, input[4:0] read_address2, output [n-1:0] R1, output [n-1:0] R2, input reset, input clk);

    reg[n-1:0] registers[31:0];
    integer i;
    always@(posedge(clk), posedge(reset)) begin
        registers[0] = 0;
        if(reset)begin
            for(i = 1; i < n; i = i + 1) begin
                  registers[i] = 0;
            end 
        end
        else if(write && (write_address != 0)) begin
            registers[write_address] = write_data;
        end    
    end
    assign R1 = registers[read_address1];
    assign R2 = registers[read_address2];
endmodule

