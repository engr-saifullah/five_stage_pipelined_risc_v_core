`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 02:58:29 PM
// Design Name: 
// Module Name: program_counter
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


module program_counter(
    input logic clk , rst, 
    input logic [31:0] PC_F,
    output logic [31:0] PCF,
    input logic StallF
    );
    always_ff @(posedge clk)begin
    if (rst) begin
        PCF <= 32'h0000_0000;
        end else if(StallF)begin
        PCF <=PCF;
        end 
        else begin
                PCF <= PC_F ;
                end
         end
endmodule
