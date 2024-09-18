`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:25:07 04/26/2024 
// Design Name: 
// Module Name:    bscfsr 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module bscfsr(
  input clk,
  output reg [3:0] CFSR = 4'b 0001,
   output reg [3:0] out
	
);




always @(posedge clk)
begin
  
  CFSR[0] <= ((~(CFSR[0] | CFSR[1] | CFSR[2]))^ (CFSR[3]))^CFSR[0];
  CFSR[1] <= CFSR[0];

  CFSR[2] <= CFSR[1] ;
  CFSR[3] <= CFSR[2];
  
  
		
if (CFSR[3] == 1'b0)
      out <= {CFSR[3:2], CFSR[0], CFSR[1]};
    else
	 
      out <= CFSR;
 
 

end


endmodule

