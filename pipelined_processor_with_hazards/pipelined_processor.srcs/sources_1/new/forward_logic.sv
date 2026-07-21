`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2026 03:32:59 PM
// Design Name: 
// Module Name: forward_logic
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


module forward_logic(
    input logic RegWriteW,
    input logic [11:7] RdW,
    input logic RegWriteM,
    input logic [11:7] RdM,
    output logic [1:0] ForwardBE,
    output logic [1:0] ForwardAE ,
    input logic [19:15] Rs1E,
    input logic [24:20] Rs2E
    
    );
    
    always_comb begin
        if(((Rs1E == RdM) & RegWriteM) & (Rs1E != 0))  // Forward from Memory stage
            ForwardAE = 2'b10;
        else if (((Rs1E == RdW) & RegWriteW) & (Rs1E != 0))  // Forward from Writeback stage
            ForwardAE = 2'b01;
        else  
            ForwardAE = 2'b00;
    
        if(((Rs1E == RdM) & RegWriteM) & (Rs1E != 0))  // Forward from Memory stage
            ForwardBE = 2'b10;
        else if (((Rs1E == RdW) & RegWriteW) & (Rs1E != 0))  // Forward from Writeback stage
            ForwardBE = 2'b01;
        else  
            ForwardBE = 2'b00;    
    end
    
endmodule
