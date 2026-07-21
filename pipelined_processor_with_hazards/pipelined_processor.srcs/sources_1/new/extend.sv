`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 04:00:38 PM
// Design Name: 
// Module Name: extend
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


module extend (
    input  logic [31:7] instr,       // Bits 31:7 from the instruction
    input  logic [1:0]  imm_src,     // ImmSrc[1:0] from the Control Unit
    output logic [31:0] imm_ext      // 32-bit sign-extended immediate
);
    always_comb begin
        case (imm_src)

            2'b00:  imm_ext = { {20{instr[31]}}, instr[31:20] };
            2'b01:  imm_ext = { {20{instr[31]}}, instr[31:25], instr[11:7] };
            2'b10:  imm_ext = { {20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0 };
            2'b11:  imm_ext = { {12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0 };
            default: imm_ext = 32'h0000_0000;
        endcase
    end
endmodule
