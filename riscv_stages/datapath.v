module datapath(
input CLK, Reset,
input [1:0] ResultSrc,
input PCSrc, ALUSrc, RegWrite,
input [1:0] ImmSrc,
input [2:0] ALUControl,
output Zero,
output [31:0] PC,
input [31:0] Instr,
output [31:0] ALUResult, WriteData,
input [31:0] ReadData
    );
    wire [31:0] Result, SrcA, ImmExt, SrcB, PCNext, PCTarget, PCPlus4;
    
    flopr #(32) pcreg(CLK, Reset, PCNext, PC);
    Adder pcadd4(PC, 32'd4, PCPlus4);
    Adder pcaddbranch(PC, ImmExt, PCTarget);
    mux2 #(32) pcmux(PCPlus4, PCTarget, PCSrc, PCNext);
    
    regfile rf(CLK, RegWrite, Instr[19:15], Instr[24:20], Instr[11:7], Result, SrcA, WriteData);
    extend ext(Instr[31:7], ImmSrc, ImmExt);
    
    mux2#(32) srcbmux(WriteData, ImmExt, ALUSrc, SrcB);
    ALU alu(SrcA, SrcB, ALUControl, ALUResult, Zero);
    mux3#(32) resultmux(ALUResult, ReadData, PCPlus4, ResultSrc, Result);
//    reg_file rf(Instr[19:15], Instr[24:20], Instr[11:7], Result, RegWrite, CLK, SrcA, outRD2);
//    ALU alu(SrcA, SrcB, ALUControl, ALUResult, Zero);
//    sign_extension EXT(Instr[31:7], ImmSrc, Immext);
//    flopr flpc(CLK, Reset, PCNext, PCans);
//    Adder PC1(PCans, ImmSrc, PCTarget);
//    Adder PC2(PCans, inc, PCPlus4);
//    mux_2x1 m1(outRD2, Immext, ALUSrc, SrcB);
//    mux_2x1 m2(PCPlus4, PCTarget, PCSrc, PCNext);
//    mux_3x1 m3(ALUResult, ReadData, PCPlus4, ResultSrc, Result);
    
endmodule