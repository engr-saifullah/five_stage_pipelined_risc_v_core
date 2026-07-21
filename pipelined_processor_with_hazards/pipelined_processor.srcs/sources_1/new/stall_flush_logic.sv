`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2026 03:52:19 PM
// Design Name: 
// Module Name: stall_flush_logic
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


module stall_flush_logic(
    input logic ResultSrcEB0,
    input logic [11:7] RdE,
    output logic FlushE , FlushD,
    input logic [19:15] Rs1D,
    input logic [24:20] Rs2D,
    input logic [19:15] Rs1E,
    input logic [24:20] Rs2E,
    output logic StallD,
    output logic StallF,
    input logic PCSrcE
    

    );
    logic lwStall;
    
    //stall logic
    always_comb begin
    lwStall = ResultSrcEB0 & ((Rs1D == RdE) | (Rs2D == RdE));
    StallF   = lwStall;
    StallD  = lwStall;
    end
    
    //flush logic
    always_comb begin 
    FlushD = PCSrcE;
    FlushE = lwStall | PCSrcE;
    end
endmodule
