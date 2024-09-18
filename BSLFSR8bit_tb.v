`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:21:04 04/23/2024
// Design Name:   BSLFSR8bit
// Module Name:   /home/ise/Vimal/LFSRBIT/BSLFSR8bit_tb.v
// Project Name:  LFSRBIT
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BSLFSR8bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module bit8cfsr_tb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs

		wire [7:0] out;



	// Instantiate the Unit Under Test (UUT)
	bit8cfsr uut (
		.clk(clk), 
		.reset(reset),
		.out(out)
	);

 initial begin
    clk = 1'b0;
	 reset=1'b0;
  end

  always #1.8 clk = ~clk;

  // Stimulus
  initial begin
    //#5;
    //repeat(256) #20;
	   
	

  end


  // Output observation
 
  
   reg [8:0] count = 9'b000000001;
always @(posedge clk) begin
    count <= count + 1;
    $display("%d) BSLSFR=%b %d , ", out,out);
	 
end
endmodule



