`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 03:59:53 PM
// Design Name: 
// Module Name: register_file
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


module register_file(
        input logic clk, rst , we3,
        input logic [4:0] a1,
        input logic [4:0] a2,
        input logic [4:0] a3,
        input logic [31:0] wd3,
        output logic [31:0] rd1,
        output logic [31:0] rd2

    );
        logic [31:0] rf[0:31];
        assign rd1 = (a1 == 5'b0) ? 32'h0000_0000 : rf[a1];
        assign rd2 = (a2 == 5'b0) ? 32'h0000_0000 : rf[a2];
        
        always_ff @(posedge clk)begin 
            if (we3 && (a3 !=5'b0))begin
                rf[a3] <= wd3 ;
                end
        end        
endmodule
