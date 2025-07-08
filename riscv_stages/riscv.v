module riscvsingle(
input CLK, Reset,
output [31:0] PC,
input [31:0] Instr,
output MemWrite,
output [31:0] ALUResult, WriteData,
input [31:0] ReadData);

    wire RegWrite, ALUSrc, Jump, Zero;
    wire [1:0] ImmSrc, ResultSrc; 
    wire [2:0] ALUControl;
    
    controller CONT(Instr[6:0], Instr[14:12], Instr[30], Zero, ResultSrc, MemWrite, PCSrc, ALUSrc, RegWrite, Jump, ImmSrc, ALUControl);
    datapath DATA(CLK, Reset, ResultSrc, PCSrc, ALUSrc, RegWrite, ImmSrc, ALUControl, Zero, PC, Instr, ALUResult, WriteData, ReadData); 

endmodule