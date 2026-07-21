`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 06:19:44 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input logic [31:0] AluResults ,
    input logic clk , rst , 
    input logic MemWrite ,
    input logic [31:0] WriteData,
    output logic [31:0] ReadData
    );
    logic [31:0] RAM [0:63];
    
    assign ReadData = RAM[AluResults[31:2]];
    
    always_ff @(posedge clk) begin
        if (MemWrite) begin
            RAM[AluResults[31:2]] <= WriteData;
            end
     end       
endmodule
