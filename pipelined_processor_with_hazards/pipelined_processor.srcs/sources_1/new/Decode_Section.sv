`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 04:18:06 PM
// Design Name: 
// Module Name: Decode_Section
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


module Decode_Section(
    input clk , rst ,
    input logic [31:0] InstrD , PCD , PCPlus4D , RDW , ResultW,
    output logic [31:0] RD1E , RD2E , PCE , RdE , PCPlus4E ,
    input logic RegWriteW ,
    output logic RegWriteE , MemWriteE , JumpE , BranchE , ALUSrcE ,
    output logic [1:0] ResultSrcE , 
    output logic [2:0] ALUControlE,
    output logic [19:15] Rs1E,
    output logic [24:20] Rs2E,
    output logic [19:15] Rs1D,
    output logic [24:20] Rs2D,
    output logic [31:7] ImmExtE
    

    );
    
    
    //INTERNAL WIRING
    logic [11:7] RdD;

    logic [31:0] ImmExtD , RD1D , RD2D;
    logic RegWriteD , MemWriteD , JumpD , BranchD , ALUSrcD;
    logic [1:0] ImmSrcD; 
    logic [1:0] ResultSrcD;
    logic [2:0] ALUControlD;
    
    //control registers
    reg  RegWrite_reg , MemWrite_reg , Jump_reg , Branch_reg , ALUSrc_reg ;
    reg [1:0] ResultSrc_reg , ImmSrc_reg;
    reg [2:0] ALUControl_reg;
    
    //datapath registers
    reg [31:0] RD1_reg , RD2_reg , PC_reg , PCPlus4_reg;
    reg [11:7] RdD_reg;
    reg [19:15] Rs1D_reg;
    reg [24:20] Rs2D_reg;    
    reg [31:7] ImmExt_Reg;
    
    assign Rs1D = InstrD[19:15];
    assign Rs2D = InstrD[24:20];
    assign RdD  = InstrD[11:7];
  
    
    //INSTANTIATION
    register_file rf(
        .a1(InstrD[19:15]),
        .a2(InstrD[24:20]),
        .a3(RDW),
        .we3(RegWriteW),
        .wd3(ResultW),
        .rd1(RD1D),
        .rd2(RD2D)
    
    );
    extend ext(
        .instr(InstrD[31:7]),
        .imm_src(ImmSrcD),
        .imm_ext(ImmExtD)
    );
    control_unit controller(
        .op(InstrD[6:0]),
        .funct3(InstrD[14:12]),
        .funct7b5(InstrD[30]),
        .ResultSrcD(ResultSrcD),
        .MemWriteD(MemWriteD),
        .AluControlD(ALUControlD),
        .ALUSrcD(ALUSrcD),
        .ImmSrcD(ImmSrcD),
        .RegWriteD(RegWriteD),
        .JumpD(JumpD),
        .BranchD(BranchD)
    );
    
    
    always_ff @(posedge clk or posedge rst)begin
        if(rst)begin
                RegWrite_reg <= 1'b0;
                MemWrite_reg <= 1'b0;
                Jump_reg <= 1'b0;
                Branch_reg <= 1'b0;
                ALUSrc_reg <= 1'b0;
                ResultSrc_reg <= 2'b00;
                ImmSrc_reg <= 2'b00;
                ALUControl_reg <= 3'b000;
                RD1_reg <= 32'h00000000;
                RD2_reg <= 32'h00000000;
                PC_reg <= 32'h00000000;
                PCPlus4_reg <= 32'h00000000;    
                RdD_reg <= 5'b00000;
                ImmExt_Reg <= 25'b0000000000000000000000000;
                Rs1D_reg <= 5'b00000;
                Rs2D_reg <= 5'b00000;
                
          
                end
        else begin
                RegWrite_reg <= RegWriteD;
                MemWrite_reg <= MemWriteD;
                Jump_reg <= JumpD;
                Branch_reg <= BranchD;
                ALUSrc_reg <= ALUSrcD;
                ResultSrc_reg <= ResultSrcD;
                ImmSrc_reg <= ImmSrcD;
                ALUControl_reg <= ALUControlD;
                RD1_reg <= RD1D;
                RD2_reg <= RD2D;
                PC_reg <= PCD;
                PCPlus4_reg <= PCPlus4D;    
                RdD_reg <= RdD;
                ImmExt_Reg <= ImmExtD;
                Rs1D_reg <= Rs1D;
                Rs2D_reg <= Rs2D;
                end
    end
        assign RegWriteE = RegWrite_reg;
        assign MemWriteE = MemWrite_reg;
        assign JumpE = Jump_reg;       
        assign BranchE = Branch_reg;
        assign ALUSrcE = ALUSrc_reg;
        assign ResultSrcE = ResultSrc_reg;       
        assign ALUControlE = ALUControl_reg;
        assign RD1E = RD1_reg;
        assign RD2E = RD2_reg;       
        assign PCE = PC_reg;
        assign PCPlus4E = PCPlus4_reg;
        assign RdE = RdD_reg;       
        assign ImmExtE = ImmExt_Reg;    
        assign Rs1E = Rs1D_reg;
        assign Rs2E = Rs2D_reg;
    
endmodule
