`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 07:12:09 PM
// Design Name: 
// Module Name: write_back_section
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


module write_back_section(
    input logic [1:0] ResultSrcW,
    input logic [31:0] ALUResultW , ReadDataW , PCPlus4W ,
    output logic [31:0] ResultW
    

    );
    
    //registers
    
    
    //instantiation
    mux3 write_back_mux(
        .in1(ALUResultW),
        .in2(ReadDataW),
        .in3(PCPlus4W),
        .s(ResultSrcW),
        .y(ResultW)
    );
    
    
    
    
endmodule
