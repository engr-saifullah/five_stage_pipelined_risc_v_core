`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 06:21:30 PM
// Design Name: 
// Module Name: memory_section
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


module memory_section(
    input logic clk,rst ,
    input logic [31:0] ALUResultM , WriteDataM , RdM , PCPlus4M, 
    input logic RegWriteM, MemWriteM, 
    input logic [1:0] ResultSrcM,
    output logic RegWriteW,
    output logic [1:0] ResultSrcW,
    output logic [31:0] ALUResultW, ReadDataW , PCPlus4W ,
    output logic [11:7] RdW
    
    
    
    

    );
    
    //internal wiring
    logic [31:0] ReadDataM;
    
    //registers
    //control registers
    reg  RegWrite_reg ;
    reg [1:0] ResultSrc_reg;
    
    //datapath registers
    reg [31:0] ALU_ResultM_reg , ReadData_reg  , PCPlus4_reg ;
    reg [11:7] Rd_reg;
    
    
    //instantiation
    data_memory data_mem(
        .clk(clk),
        .rst(rst),
        .AluResults(ALUResultM),
        .MemWrite(MemWriteM),
        .WriteData(WriteDataM),
        .ReadData(ReadDataM)
    
    );
    
    
            always_ff @(posedge clk or posedge rst)begin
    if(rst)begin
            RegWrite_reg <= 1'b0;
            ResultSrc_reg <= 2'b00;
            ALU_ResultM_reg <= 32'h00000000;
            ReadData_reg <= 32'h00000000;
            PCPlus4_reg <= 32'h00000000;    
            Rd_reg <= 5'b00000;
 
            end
    else begin
            RegWrite_reg <= RegWriteM;
            ResultSrc_reg <= ResultSrcM;
            ALU_ResultM_reg <= ALUResultM;
            ReadData_reg <= ReadDataM;
            PCPlus4_reg <= PCPlus4M;    
            Rd_reg <= RdM;
            end
end
    assign RegWriteW = RegWrite_reg;
    assign ResultSrcW = ResultSrc_reg;       
    assign ALUResultW = ALU_ResultM_reg;
    assign ReadDataW = ReadData_reg;
    assign PCPlus4W = PCPlus4_reg;
    assign RdW = Rd_reg;  
    
    
endmodule
