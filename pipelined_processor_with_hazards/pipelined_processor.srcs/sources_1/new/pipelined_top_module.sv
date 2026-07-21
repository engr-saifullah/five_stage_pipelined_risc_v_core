`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 07:24:22 PM
// Design Name: 
// Module Name: pipelined_top_module
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


module pipelined_top_module(
    input clk , rst 

    );
    
    //wiring
    logic PCSrcE;
    logic [31:0] PCTargetE , InstrD , PCD , PCPlus4D  , ResultW , RD1E , RD2E , PCE , ImmExtE , PCPlus4E;
    logic [11:7] RdE , RdM , RdW ;
    logic RegWriteW , RegWriteE , MemWriteE , JumpE , BranchE , ALUSrcE;
    logic [1:0] ResultSrcE , ResultSrcM , ResultSrcW;
    logic [2:0] ALUControlE ;
    logic [31:0] ALUResultM , WriteDataM , PCPlus4M , ReadDataW , PCPlus4W , ALUResultW;
    logic RegWriteM , MemWriteM;
    logic [1:0] ForwardAE , ForwardBE;
    logic [19:15] Rs1E;
    logic [24:20] Rs2E;
    logic FlushE , StallF , StallD , FlushD;
    logic [19:15] Rs1D;
    logic [24:20] Rs2D;
    
    
    //instantiation
    Fetch_Section fetch(
        .clk(clk),
        .rst(rst),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D),
        .StallD(StallD),
        .FlushD(FlushD),
        .StallF(StallF)
    );
    
    Decode_Section decode(
        .clk(clk),
        .rst(rst),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D),
        .RDW(RdW),
        .ResultW(ResultW),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .PCE(PCE),
        .RdE(RdE),
        .ImmExtE(ImmExtE),
        .PCPlus4E(PCPlus4E),
        .RegWriteW(RegWriteW),
        .RegWriteE(RegWriteE),
        .MemWriteE(MemWriteE),
        .JumpE(JumpE),
        .BranchE(BranchE),
        .ALUSrcE(ALUSrcE),
        .ResultSrcE(ResultSrcE),
        .ALUControlE(ALUControlE),
        .Rs1E(Rs1E),
        .Rs2E(Rs2E),
        .Rs1D(Rs1D),
        .Rs2D(Rs2D)

        
    );
    
    Execute_Section execute(
        .clk(clk),
        .rst(rst),
        .RegWriteE(RegWriteE),
        .MemWriteE(MemWriteE),
        .JumpE(JumpE),
        .BranchE(BranchE),
        .ALUSrcE(ALUSrcE),
        .ResultSrcE(ResultSrcE),
        .ALUControlE(ALUControlE),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .PCE(PCE),
        .RdE(RdE),
        .ImmExtE(ImmExtE),
        .PCPlus4E(PCPlus4E),
        .PCTargetE(PCTargetE),
        .ALUResultM(ALUResultM),
        .WriteDataM(WriteDataM),
        .PCPlus4M(PCPlus4M),
        .RdM(RdM),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .PCSrcE(PCSrcE),
        .ResultSrcM(ResultSrcM),
        .ResultW(ResultW),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .FlushE(FlushE)
        
        
    );
    
    memory_section memory(
        .clk(clk),
        .rst(rst),
        .ALUResultM(ALUResultM),
        .WriteDataM(WriteDataM),
        .RdM(RdM),
        .PCPlus4M(PCPlus4M),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM),
        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW),
        .ALUResultW(ALUResultW),
        .ReadDataW(ReadDataW),
        .PCPlus4W(PCPlus4W),
        .RdW(RdW)
    );
    
    write_back_section write_back(
        .ResultSrcW(ResultSrcW),
        .ALUResultW(ALUResultW),
        .ReadDataW(ReadDataW),
        .PCPlus4W(PCPlus4W),
        .ResultW(ResultW)
    );
    
    
    //hazards
    forward_logic forward(
        .RegWriteW(RegWriteW),
        .RdW(RdW),
        .RegWriteM(RegWriteM),
        .RdM(RdM),
        .ForwardBE(ForwardBE),
        .ForwardAE(ForwardAE),
        .Rs1E(Rs1E),
        .Rs2E(Rs2E)
    
    );
    
    stall_flush_logic stall_flush(
        .ResultSrcEB0(ResultSrcE[0]),
        .RdE(RdE),
        .FlushE(FlushE),
        .FlushD(FlushD),
        .Rs1D(Rs1D),
        .Rs2D(Rs2D),
        .StallD(StallD),
        .StallF(StallF),
        .PCSrcE(PCSrcE),
        .Rs1E(Rs1E),
        .Rs2E(Rs2E)
    
    );
    
    
endmodule
