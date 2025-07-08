module ID_stage( input CLK,
    input [31:0] InstrD,
    input [31:0] PCD,
    input [31:0] PCPlus4D,
    input [31:0] WD,
    input [4:0] WriteAddr,
    input [31:0] WE,
    input CLR,
    output RegWriteE,
    output [1:0] ResultSrcE,
    output MemWriteE,
    output JumpE,
    output BranchE,
    output [2:0] ALUControlE,
    output ALUSrcE,
    output [31:0] RD1E,
    output [31:0] RD2E,
    output [31:0] PCE,
    output [4:0] Rs1E,
    output [4:0] Rs2E,
    output [4:0] RdE,
    output [31:0] ImmExtE,
    output [31:0] PCPlus4E,
    output [4:0] rs1d, rs2d
);
    wire [1:0] ImmSrcD;
    wire [31:0] ImmExtD;
    wire [31:0] RD1, RD2;
    wire [1:0] ResultSrcD;
    wire MemWriteD, JumpD, BranchD, ALUSrcD, RegWriteD;
    wire [1:0] ImmSrcD;
    wire [2:0] ALUControlD;

    reg RegWriteEr, MemWriteEr, JumpEr, BranchEr, ALUSrcEr;
    reg [1:0] ResultSrcEr;
    reg [2:0] ALUControlEr;
    reg [31:0] RD1Er, RD2Er, PCEr, ImmExtEr, PCPlus4Er;
    reg [4:0] Rs1Er, Rs2Er, RdEr;

    extend ext(InstrD[31:7], ImmSrcD, ImmExtD);
    regfile rf(CLK, WE, InstrD[19:15], InstrD[24:20], WriteAddr, RD1, RD2);
    controller cont(InstrD[6:0], InstrD[14:12], InstrD[30], ResultSrcD, MemWriteD, ALUSrcD, RegWriteD, JumpD, ImmSrcD, ALUControlD, BranchD);

    always@(posedge CLK, negedge CLR)begin 
        if(!CLR) begin 
            ResultSrcEr <=2'b0;
            RegWriteEr <= 1'b0; MemWriteEr <= 1'b0; JumpEr <= 1'b0; BranchEr <=1'b0; ALUSrcEr <= 1'b0;
            ALUControlEr <= 3'b0;
            RD1Er <= 32'b0; RD2Er <= 32'b0; PCEr <= 32'b0; ImmExtEr <= 32'b0; PCPlus4Er <= 32'b0;
            Rs1Er <= 5'b0; Rs2Er <= 32'b0; RdEr <= 32'b0;
        end
        else begin 
            ResultSrcEr <= ResultSrcD; 
            RegWriteEr <= RegWriteD; MemWriteEr <= MemWriteD;JumpEr <= JumpD; BranchEr <= BranchD; ALUSrcEr <= ALUSrcD;
            ALUControlEr <= ALUControlD;
            RD1Er <= RD1; RD2Er <= RD2; PCEr <= PCD; ImmExtEr <= ImmExtD; PCPlus4Er <= PCPlus4D;
            Rs1Er <= InstrD[19:15]; Rs2Er <= InstrD[24:20]; RdEr <= InstrD[11:7];

        end
    end

    assign rs1d = InstrD[19:15], rs2d = InstrD[24:20];

    assign RegWriteE = RegWriteEr, MemWriteE = MemWriteEr, JumpE = JumpEr, BranchE = BranchEr, ALUSrcE = ALUSrcEr;
    assign ResultSrcE = ResultSrcEr, ALUControlE = ALUControlEr;
    assign RD1E = RD1Er, RD2E = RD2Er, PCE = PCEr, Rs1E = Rs1Er, Rs2E = Rs2Er, RdE = RdEr, ImmExtE = ImmExtEr, PCPlus4E = PCPlus4Er;


endmodule

// module controller(
// input [6:0] op,
// input [2:0] funct3,
// input funct7,
// output [1:0] ResultSrc,
// output MemWrite,
// output ALUSrc,
// output RegWrite, Jump,
// output [1:0] ImmSrc,
// output [2:0] ALUControl
//     );