`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 05:22:22 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input logic [31:0] SrcA,
    input logic [31:0] SrcB,
    input logic [2:0]  AluControl,
    output logic zero,
    output logic [31:0] AluResults
    );
    always_comb begin
        case (AluControl)
            3'b000 : AluResults = SrcA + SrcB;
            3'b001 : AluResults = SrcA - SrcB;
            3'b010 : AluResults = SrcA & SrcB;
            3'b011 : AluResults = SrcA | SrcB;
            3'b100 : AluResults = SrcA ^ SrcB;
            3'b101 : AluResults = SrcA << SrcB[4:0];
            3'b110 : AluResults = SrcA >> SrcB[4:0];
            default : AluResults = 32'h0;          
        endcase
    end
    assign zero = (AluResults == 32'h0);
endmodule
