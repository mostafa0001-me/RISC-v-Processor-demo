`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2023 08:13:54 PM
// Design Name: 
// Module Name: Processor
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


module Processor(input clk, input reset, input [1:0] LedSel, input [3:0] ssdSel,
    input ssdClk, output reg[15:0] Leds, output [6:0] LED_out, output[3:0] Anode);
    //wires
    reg[12:0] ssd;
    reg[31:0] PC;
    reg[5:0] address;
    wire[31:0] inst;
    wire[31:0] regdata1;
    wire[31:0] regdata2;
    wire[31:0] pc4;
    wire[1:0] aluop;
    wire branch, memread, memtoreg, memwrite, alusrc, regwrite;
    wire[31:0] dataToWrite;
    wire[31:0] immediate;
    wire[31:0] offset;
    wire[31:0] dataToAlu;
    wire[31:0] jumpaddress;
    wire[3:0] alucont;
    wire[31:0] aluoutput;
    wire zflag;
    wire andout;
    wire[31:0] memoutput;
    wire[31:0] outputtoPC;
    
    
    // pipline
    // wires declarations
    // the module "Register" is an n-bit register module with n as a parameter
    // and with I/O's (clk, rst, load, data_in, data_out) in sequence
    wire [31:0] IF_ID_PC, IF_ID_Inst;
     Register #(64) IF_ID (clk,reset,1'b1,
     {PC, inst},
     {IF_ID_PC,IF_ID_Inst} );
    
    wire [31:0] ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm;
    wire [7:0] ID_EX_Ctrl;
    wire [31:0] ID_EX_Func;
    wire [4:0] ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd;
     Register #(183) ID_EX (clk,reset,1'b1,
     {alusrc, aluop, branch, memread,  memwrite, regwrite, memtoreg, IF_ID_PC,
     regdata1, regdata2, immediate, IF_ID_Inst, IF_ID_Inst[19:15], 
     IF_ID_Inst[24:20], IF_ID_Inst[11:7]},
     {ID_EX_Ctrl,ID_EX_PC,ID_EX_RegR1,ID_EX_RegR2,
     ID_EX_Imm, ID_EX_Func,ID_EX_Rs1,ID_EX_Rs2,ID_EX_Rd} );
     // Rs1 and Rs2 are needed later for the forwarding unit
    
    wire [31:0] EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_RegR2;
    wire [4:0] EX_MEM_Ctrl;
    wire [4:0] EX_MEM_Rd;
    wire EX_MEM_Zero;
     Register #(107) EX_MEM (clk,reset,1'b1,
     {ID_EX_Ctrl[4:0], jumpaddress, zflag, aluoutput, ID_EX_RegR2, ID_EX_Rd},
     {EX_MEM_Ctrl, EX_MEM_BranchAddOut, EX_MEM_Zero,
     EX_MEM_ALU_out, EX_MEM_RegR2, EX_MEM_Rd} );
    
    wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out;
    wire [1:0] MEM_WB_Ctrl;
    wire [4:0] MEM_WB_Rd;
     Register #(71) MEM_WB (clk,reset,1'b1,
     {EX_MEM_Ctrl[1:0], memoutput, EX_MEM_ALU_out, EX_MEM_Rd},
     {MEM_WB_Ctrl,MEM_WB_Mem_out, MEM_WB_ALU_out,
     MEM_WB_Rd} );
    
     // all modules instantiations
     // LED and SSD outputs case statements
    
    
    //modules
    assign andout = EX_MEM_Ctrl[4] & EX_MEM_Zero;
    InstMem instout(.addr({PC[7:2]}), .data_out(inst));
    assign pc4 = PC + 4;
    control_unit cont(.instruction(IF_ID_Inst), .branch(branch), .memread(memread), .memtoreg(memtoreg), .memwrite(memwrite), .alusrc(alusrc), .regwrite(regwrite), .aluop(aluop));
    registerfile#(32) rf(.write(MEM_WB_Ctrl[1]), .write_data(dataToWrite), .write_address(MEM_WB_Rd), .read_address1(IF_ID_Inst[19:15]), .read_address2(IF_ID_Inst[24:20]), .R1(regdata1), .R2(regdata2), .reset(reset), .clk(clk));
    ImmGen imm(.gen_out(immediate), .inst(IF_ID_Inst));
    shift#(32) sh(.A(ID_EX_Imm), .B(offset));
    assign dataToAlu = ID_EX_Ctrl[7] ? ID_EX_Imm: ID_EX_RegR2; 
    assign jumpaddress = ID_EX_PC + offset;
    ALU_control_unit contalu(.aluop(ID_EX_Ctrl[6:5]),.inreg(ID_EX_Func),.select(alucont));
    ALU #(32) alu(.clk(clk),.cin(1'b0),.a(ID_EX_RegR1),.b(dataToAlu),.select(alucont),.zflag(zflag),.out(aluoutput));
    DataMem mem(.clk(clk), .MemRead(EX_MEM_Ctrl[3]), .MemWrite(EX_MEM_Ctrl[2]),.addr({2'b00, EX_MEM_ALU_out[5:2]}), .data_in(EX_MEM_RegR2), .data_out(memoutput));
    assign dataToWrite = MEM_WB_Ctrl[0] ?  MEM_WB_Mem_out :MEM_WB_ALU_out;
    assign outputtoPC = andout ? EX_MEM_BranchAddOut: pc4;
    Four_Digit_Seven_Segment_Driver ssddrive(.clk(ssdClk),.num(ssd),.Anode(Anode),.LED_out(LED_out));
    
    always @(posedge(clk) or posedge(reset))begin
        if(reset)
            PC = 0;
        else
            PC = outputtoPC;
//        address = PC[5:0];
   end
    always @(*) begin   
        case(LedSel)
            2'b00: Leds = inst[15:0];
            2'b01: Leds = inst[31:16];
            2'b10: Leds = {2'b0, aluop,alucont,zflag,andout, branch, memread, memtoreg, memwrite, alusrc, regwrite};
            default: Leds = 16'b0;
        endcase
        
        case(ssdSel)
            0: ssd = PC[12:0];
            1: ssd = pc4[12:0];
            2: ssd = jumpaddress[12:0];
            3: ssd = outputtoPC[12:0];
            4: ssd = regdata1[12:0];
            5: ssd = regdata2[12:0];
            6: ssd = dataToWrite[12:0];
            7: ssd = immediate[12:0];
            8: ssd = offset[12:0];
            9: ssd = dataToAlu[12:0];
            10: ssd = aluoutput[12:0];
            11: ssd = memoutput[12:0];
            12: ssd = MEM_WB_Rd;
            default ssd = 13'b0;           
        endcase
    end
endmodule
