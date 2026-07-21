`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 05:26:50 PM
// Design Name: 
// Module Name: Execute_Section
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


module Execute_Section(
    input logic clk, rst,
    input logic RegWriteE , MemWriteE , JumpE , BranchE , ALUSrcE ,
    input logic [1:0] ResultSrcE , 
    input logic [2:0] ALUControlE,
    input logic [31:0] RD1E , RD2E , WriteDataE , PCE , RdE , ImmExtE , PCPlus4E ,
    output logic [31:0] PCTargetE , ALUResultM , WriteDataM  , PCPlus4M , 
    output logic [11:7] RdM,
    output logic RegWriteM, MemWriteM , PCSrcE, 
    output logic [1:0] ResultSrcM,
    input logic [1:0] ForwardAE, ForwardBE ,
    input logic [31:0] ResultW,
    input FlushE
    
    
    
    

    );
    
    //INTERNAL WIRING
    logic [31:0] SrcBE , SrcAE , ALUOut;
    logic zeroE;
    
    assign PCSrcE = JumpE || (BranchE && zeroE);
    
    //registers
    //control registers
    reg  RegWrite_reg , MemWrite_reg  ;
    reg [1:0] ResultSrc_reg;
    
    //datapath registers
    reg [31:0] ALU_ResultM_reg , WriteData_reg , PCPlus4_reg;
    reg [11:7] Rd_reg;
    
    //INSTATIATION
    alu alu_unit(
        .SrcA(SrcAE),
        .SrcB(SrcBE),
        .AluControl(ALUControlE),
        .zero(zeroE),
        .AluResults(ALUOut)
    );  
    mux alu_mux(
        .a(WriteDataE),
        .b(ImmExtE),
        .s(ALUSrcE),
        .c(SrcBE)
    );
    
    mux3 srcae_mux(
        .in1(RD1E),
        .in2(ResultW),
        .in3(ALUResultM),
        .s(ForwardAE),
        .y(SrcAE)
    );
    
    mux3 srcbe_mux(
        .in1(RD2E),
        .in2(ResultW),
        .in3(ALUResultM),
        .s(ForwardBE),
        .y(WriteDataE)
    );
        
    adder pc_target_adder(
        .a(PCE),
        .b(ImmExtE),
        .y(PCTargetE)
    );
    
    
        always_ff @(posedge clk or posedge rst)begin
        if(rst)begin
                RegWrite_reg <= 1'b0;
                MemWrite_reg <= 1'b0;
                ResultSrc_reg <= 2'b00;
                ALU_ResultM_reg <= 32'h00000000;
                WriteData_reg <= 32'h00000000;                
                PCPlus4_reg <= 32'h00000000;    
                Rd_reg <= 5'b00000;
     
                end
        else if(FlushE) begin
                RegWrite_reg <= 1'b0;
                MemWrite_reg <= 1'b0;
                ResultSrc_reg <= 2'b00;
                ALU_ResultM_reg <= 32'h00000000;
                WriteData_reg <= 32'h00000000;                
                PCPlus4_reg <= 32'h00000000;    
                Rd_reg <= 5'b00000;        
        end 
        else begin
                RegWrite_reg <= RegWriteE;
                MemWrite_reg <= MemWriteE;
                ResultSrc_reg <= ResultSrcE;
                ALU_ResultM_reg <= ALUOut;
                WriteData_reg <= WriteDataE; 
                PCPlus4_reg <= PCPlus4E;    
                Rd_reg <= RdE;
                end
    end
        assign RegWriteM = RegWrite_reg;
        assign MemWriteM = MemWrite_reg;
        assign ResultSrcM = ResultSrc_reg;       
        assign ALUResultM = ALU_ResultM_reg;
        assign WriteDataM = WriteData_reg; 
        assign PCPlus4M = PCPlus4_reg;
        assign RdM = Rd_reg;       

    
    
endmodule
