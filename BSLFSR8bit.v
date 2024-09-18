`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:30:43 05/23/2024 
// Design Name: 
// Module Name:    BSLFSR8bit 
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
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:07:59 04/23/2024 
// Design Name: 
// Module Name:    lfsr8bit 
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
module BSLFSR8bit(
  input clk,
  output reg [7:0] LFSR = 8'b10001000,
  output reg [7:0] out
 // Initial value
);
always @(posedge clk)
begin
  LFSR[0] <= ((LFSR[5] ^ LFSR[7]) ^ LFSR[4]) ^ LFSR[3];
  LFSR[1] <= LFSR[0];
  LFSR[2] <= LFSR[1];
  LFSR[3] <= LFSR[2];
  LFSR[4] <= LFSR[3];
  LFSR[5] <= LFSR[4];
  LFSR[6] <= LFSR[5];
  LFSR[7] <= LFSR[6];
  
  
    if (LFSR[7] == 1'b0)
      out <= {LFSR[7:6], LFSR[4], LFSR[5],LFSR[2], LFSR[3],LFSR[0], LFSR[1]};
    else
	 
      out <= LFSR;

end
endmodule




