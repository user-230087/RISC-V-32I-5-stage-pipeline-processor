module processor(input CLK, reset);

    wire [31:0] PCTargetE, instraddr;
    wire PCSrcE, StallF, EN, Clrif, RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcE, RegWriteM, MemWriteM, RegWriteW, FlushD;
    wire [4:0] RdW, Rs1E, Rs2E, RdE, RdM, RD, RdW, Rs1D, Rs2D;
    wire [31:0] Inst, InstrD, PCD, PCPlus4D, ResultW, PCE, RD1E, RD2E, PCPlus4E, ImmExtE, ALUResultM, WriteDataM, PCPlus4M, ALUResultW, ReadDataW, PCPlus4W;
    wire [1:0] ResultSrcE, ForwardAE, ForwardBE, ResultSrcM, ResultSrcW;

    IF_stage if_st(PCTargetE, CLK, reset, PCSrcE, StallF, EN, FlushD, Instr, InstrD, PCD, PCPlus4D, instraddr);
    ID_stage id(CLK, InstrD, PCD, PCPlus4D, ResultW, RdW, RegWriteW, FlushE, RegWriteE, ResultSrcE, MemWriteE, JumpE, BranchE, ALUControlE, ALUSrcE, RD1E, RD2E, PCE, Rs1E, Rs2E, RdE, ImmExtE, PCPlus4E, Rs1D, Rs2D);
    EX_stage ex(CLK, reset, RegWriteE, MemWriteE,JumpE, BranchE, ALUSrcE, ResultSrcE, ALUControlE, RD1E, RD2E, PCE, Rs1E, Rs2E, RdE, ImmExtE, PCPlus4E, ResultW, ALUResultM, ForwardAE, ForwardBE, RegWriteM, ResultSrcM, MemWriteM, ALUResultM, WriteDataM, RdM, PCPlus4M, PCTargetE, PCSrcE);
    MEM_stage mem(CLK, RegWriteM, ResultSrcM, MemWriteM, ALUResultM, WriteDataM, RdM, PCPlus4M, RD, RegWriteW, ResultSrcW, ALUResultW, ReadDataW, RdW, PCPlus4W);
    WB_stage wb(CLK, ResultSrcW, ALUResultW, ReadDataW, RdW, PCPlus4W, ResultW);

    hazard_unit hu(StallF, StallD, FlushD, FlushE, ForwardAE, ForwardBE, Rs1D, Rs2D, RdE, Rs2E, Rs1E, RdM, RdW, PCSrcE, RegWriteM, RegWriteW, ResultSrcE);



    imem imem(instraddr, Instr);
    dmem dmem(CLK, MemWriteM, ALUResultM, WriteDataM, RD);



endmodule


// module IF_stage(input [31:0] PCTargetE,
// input CLK, Reset, PCSrcE, StallF, EN, Clr,
// input [31:0] Instr,
// output [31:0] InstrD,
// output [31:0] PC_o,
// output [31:0] PCPlus4F_o,
// output [31:0] PCF);
