`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 03:02:13 PM
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory(
    input logic [31:0] PCF,
    output logic [31:0] InstrF
    );   
    logic [31:0] ROM [0:63]; 
    assign InstrF = ROM[PCF[31:2]]; 
    initial begin 
        $readmemh("program.txt" , ROM);
        end 
endmodule
