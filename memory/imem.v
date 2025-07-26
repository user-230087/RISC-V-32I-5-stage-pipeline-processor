`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2025 16:46:35
// Design Name: 
// Module Name: imem
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


module imem(
input [31:0] a,
output [31:0] rd
    );
    
    reg [31:0] RAM[63:0];
    
    initial $readmemh("riscvtest.txt", RAM);
    
    assign rd = RAM[a[31:2]];
endmodule
