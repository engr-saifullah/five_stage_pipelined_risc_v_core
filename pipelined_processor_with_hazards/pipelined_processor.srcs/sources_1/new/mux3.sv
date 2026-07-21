`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 07:17:30 PM
// Design Name: 
// Module Name: mux3
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


module mux3(
input logic [31:0] in1,
input logic [31:0] in2,
input logic [31:0] in3,
input logic [1:0] s,
output logic [31:0] y

    );
    
    always @(*) begin
    case (s)
        2'b00: y = in1;
        2'b01: y = in2;
        2'b10: y = in3;
        default : y = 32'b0;
        
        endcase
      end
        
    
    
    
endmodule
