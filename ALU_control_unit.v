`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2023 11:55:33 AM
// Design Name: 
// Module Name: ALU_control_unit
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


module ALU_control_unit(input[1:0] aluop,input[31:0] inreg,output reg[3:0] select);

always@(*)
begin
	if (aluop == 2'b00) select = 4'b0010; 	// add
 	else if (aluop == 2'b01) select = 4'b110;	// sub
	else if (aluop == 2'b10 && inreg[14:12] == 3'b000 && inreg[30] ==0 ) select = 4'b0010; // add
	else if (aluop == 2'b10 && inreg[14:12] == 3'b000 && inreg[30] ==1 ) select = 4'b0110; // sub
	else if (aluop == 2'b10 && inreg[14:12] == 3'b111 && inreg[30] ==0 ) select = 4'b0000; // and
	else if (aluop == 2'b10 && inreg[14:12] == 3'b110 && inreg[30] ==0 ) select = 4'b0001; // and
	else select = 4'b1111;
end

endmodule
