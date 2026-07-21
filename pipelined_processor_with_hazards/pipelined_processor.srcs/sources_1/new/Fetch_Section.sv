`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 03:06:05 PM
// Design Name: 
// Module Name: Fetch_Section
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


module Fetch_Section(
        input logic clk,rst,
        input logic PCSrcE,
        input logic [31:0] PCTargetE,
        output logic [31:0] InstrD,
        output logic [31:0] PCD,
        output logic [31:0] PCPlus4D,
        input logic StallD , FlushD , StallF
        
    );
    
    //INTERNAL WIRING
    logic [31:0] PCPlus4F , PC_F , PCF , InstrF;
    reg [31:0] Instruction_reg;
    reg [31:0] PC_reg;
    reg [31:0] PC_Plus4_reg;
    
    
    //module instantiation
    mux pc_mux(
        .a(PCPlus4F),
        .b(PCTargetE),
        .s(PCSrcE),
        .c(PC_F)
    
    );
    
    program_counter prog_counter(
        .clk(clk),
        .rst(rst),
        .PC_F(PC_F),
        .PCF(PCF),
        .StallF(StallF)
    
    );
    instruction_memory instr_mem(
        .PCF(PCF),
        .InstrF(InstrF)
    );
    adder pc_plus4(
        .a(PCF),
        .b(32'h00000004),
        .y(PCPlus4F)
    );
 
    always_ff @(posedge clk or posedge rst)begin
        if(rst)begin
                Instruction_reg <= 32'h00000000;
                PC_reg <= 32'h00000000;
                PC_Plus4_reg <= 32'h00000000;              
                end
        else if(FlushD)begin
                Instruction_reg <= 32'h00000000;
                PC_reg <= 32'h00000000;
                PC_Plus4_reg <= 32'h00000000;              
                end
        else if(StallD)begin
                Instruction_reg <= Instruction_reg;
                PC_reg <= PC_reg;
                PC_Plus4_reg <= PC_Plus4_reg;
        end                      
        else begin
                Instruction_reg <= InstrF;
                PC_reg <= PCF;
                PC_Plus4_reg <= PCPlus4F;         
                end
    end
        assign InstrD = Instruction_reg;
        assign PCD = PC_reg;
        assign PCPlus4D = PC_Plus4_reg;    
endmodule
