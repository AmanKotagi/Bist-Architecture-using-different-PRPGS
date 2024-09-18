`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:28:11 04/26/2024
// Design Name:   bscfsr
// Module Name:   /home/ise/Vimal/BSCFSR/bscfsr_tb.v
// Project Name:  BSCFSR
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: bscfsr
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module bscfsr_tb;

  // Inputs
  reg clk;

  // Outputs
 
  wire [3:0] CFSR;
  wire [3:0] out;
  
    

  

  // Instantiate the Unit Under Test (UUT)
  bscfsr uut (
    .clk(clk),
	.CFSR(CFSR),
	.out(out)

  );

  // Clock generation
  initial begin
    clk = 1'b0;
  end

  always #10 clk = ~clk;

  // Stimulus
  initial begin
    #10;
    repeat(18) #20;
	 $dumpfile("power_fileq.vcd");
    $dumpvars (0, bscfsr_tb.uut); 
		
  // Correct module instance name
    $finish; // Move $finish after dumping waveform
	   
end



  // Output observation
 
  
   reg [4:0] count = 5'b00001;
always @(posedge clk) begin
    count <= count + 1;
    $display("%d) CFSR=%b  %d out=%b %d ",count,CFSR,CFSR,out,out);
	 
end
endmodule

