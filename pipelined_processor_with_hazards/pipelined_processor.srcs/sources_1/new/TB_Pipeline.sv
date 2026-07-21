`timescale 1ns / 1ps

module tb_pipelined_top_module();

    // Inputs to the UUT (Unit Under Test)
    logic clk;
    logic rst;

    // Instantiate the Unit Under Test
    pipelined_top_module uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock Generation (100MHz -> 10ns period)
    always begin
        #5 clk = ~clk;
    end

    // Stimulus Block
    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        // Hold reset active for 2 clock cycles to clear internal pipeline registers
        #20;      
        // De-assert reset on a falling edge to avoid setup/hold timing violations
        @(negedge clk);
        rst = 0;
        #110; 
        $finish;
    end
    

endmodule