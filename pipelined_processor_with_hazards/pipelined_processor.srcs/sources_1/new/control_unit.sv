`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 04:01:34 PM
// Design Name: 
// Module Name: control_unit
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

module control_unit (
    input  logic [6:0] op,          // Instr[6:0]
    input  logic [2:0] funct3,      // Instr[14:12]
    input  logic       funct7b5,    // Instr[30]
    //input  logic       zero,        // zero flag from ALU
    //output logic       PCSrc,
    output logic [1:0] ResultSrcD,
    output logic       MemWriteD,
    output logic [2:0] AluControlD,
    output logic       ALUSrcD,
    output logic [1:0] ImmSrcD,
    output logic       RegWriteD,
    output logic JumpD,
    output logic BranchD
);

    logic [1:0] alu_op;
   

  always_comb begin
       
        RegWriteD  = 1'b0;
        ImmSrcD    = 2'b00;
        ALUSrcD    = 1'b0;
        MemWriteD  = 1'b0;
        ResultSrcD = 2'b00;
        BranchD    = 1'b0;
        JumpD      = 1'b0;
        alu_op    = 2'b00;
        case (op)
            7'b0110011: begin
                RegWriteD  = 1'b1;
                ALUSrcD    = 1'b0;
                ResultSrcD = 2'b00;
                alu_op    = 2'b10; 
            end
            // I-type ALU (addi, andi, ori, etc.)
            7'b0010011: begin
                RegWriteD  = 1'b1;
                ImmSrcD    = 2'b00;
                ALUSrcD    = 1'b1;
                ResultSrcD = 2'b00;
                alu_op    = 2'b10; 
            end
            // I-type Load (lw)
            7'b0000011: begin
                RegWriteD  = 1'b1;
                ImmSrcD    = 2'b00;
                ALUSrcD    = 1'b1;
                ResultSrcD = 2'b01; 
                alu_op    = 2'b00; 
            end
            // S-type Store (sw)
            7'b0100011: begin
                ImmSrcD    = 2'b01;
                ALUSrcD    = 1'b1;
                MemWriteD  = 1'b1;
                alu_op    = 2'b00; 
            end
            // B-type Branch (beq)
            7'b1100011: begin
                ImmSrcD    = 2'b10;
                ALUSrcD    = 1'b0;
                BranchD    = 1'b1;
                alu_op    = 2'b01; 
            end
            // J-type Jump (jal)
            7'b1101111: begin
                RegWriteD  = 1'b1;
                ImmSrcD    = 2'b11;
                ResultSrcD = 2'b10; 
                JumpD      = 1'b1;
            end
            default: ; 
        endcase
    end
  always_comb begin
        case (alu_op)
            2'b00: AluControlD = 3'b000; 
            2'b01: AluControlD = 3'b001; 
            
            2'b10: begin // R-type & I-type choices dependent on funct codes
                case (funct3)
                    3'b000: begin
                     if (op[5] && funct7b5) 
                            AluControlD = 3'b001; // SUB
                        else                   
                            AluControlD = 3'b000; // ADD / ADDI
                    end
                    3'b111: AluControlD = 3'b010; // AND / ANDI
                    3'b110: AluControlD = 3'b011; // OR / ORI
                    3'b100: AluControlD = 3'b100; // XOR / XORI
                    3'b001: AluControlD = 3'b101; // SLL / SLLI
                    3'b101: AluControlD = 3'b110; // SRL / SRLI
                    default: AluControlD = 3'b000;
                endcase
            end        
            default: AluControlD = 3'b000;
        endcase
    end
  
endmodule
