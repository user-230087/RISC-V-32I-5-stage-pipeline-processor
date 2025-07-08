module EX_stage(input CLK, reset,
input RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcE,
input [1:0] ResultSrcE,
input [2:0] ALUControlE,
input [31:0] RD1E, RD2E, PCE,
input [4:0] Rs1E, Rs2E, RdE,
input [31:0] ImmExtE, PCPlus4E,

input [31:0] ResultW, Intm,
input [1:0] ForwardAE, ForwardBE,

output RegWriteM,
output [1:0] ResultSrcM,
output MemWriteM,
output [31:0] ALUResultM,
output [4:0] WriteDataM,
output [4:0] RdM,
output [31:0] PCPlus4M,

output [31:0] PCTargetE,
output PCSrcE
);

wire [31:0] SrcA, SrcB, ALUResult, WriteDataE;
wire ZeroE;

reg RegWriteMr, MemWriteMr;
reg [1:0] ResultSrcMr;
reg [31:0] ALUResultMr, WriteDataMr, PCPlus4Mr;
reg[4:0] RdMr;

Adder pcaddbranch(PCE, ImmExtE, PCTargetE);
ALU alu(SrcA, SrcB, ALUControlE, ALUResult, ZeroE);
mux3 #(32) (RD1E, ResultW, Intm, ForwardAE, SrcA);
mux3 #(32) (RD2E, ResultW, Intm, ForwardBE, WriteDataE);
mux2 #(32) (WriteDataE, ImmExtE, ALUSrcE, SrcB);

always @(posedge CLK, negedge reset) begin 
    if(!reset) begin 
        RegWriteMr = 0; ResultSrcMr = 0; MemWriteMr = 0;
        ALUResultMr = 0; WriteDataMr = 0; RdMr = 0; PCPlus4Mr = 0;
    end
    else begin 
        RegWriteMr = RegWriteE; ResultSrcMr = ResultSrcE; MemWriteMr = MemWriteE;
        ALUResultMr = ALUResult; WriteDataMr = WriteDataE; RdMr = RdE; PCPlus4Mr = PCPlus4E;
    end
end


assign PCSrcE = ZeroE & BranchE | JumpE;

assign RegWriteM = RegWriteMr, ResultSrcM = ResultSrcMr, MemWriteM = MemWriteMr;
assign ALUResultM = ALUResultMr, WriteDataM = WriteDataMr, RdM = RdMr, PCPlus4M = PCPlus4Mr;

endmodule

// module mux3 #(parameter WIDTH = 8)
// ( input [WIDTH-1:0] d0, d1, d2,
// input [1:0] s,
// output [WIDTH-1:0] y);

// assign y = s[1] ? d2 : (s[0] ? d1 : d0);
