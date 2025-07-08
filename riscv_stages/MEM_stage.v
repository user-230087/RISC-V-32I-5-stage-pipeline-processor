module MEM_stage(input CLK,
input RegWriteM, 
input [1:0] ResultSrcM,
input MemWriteM,
input [31:0] ALUResultM,
input [31:0] WriteDataM,
input [4:0] RdM,
input [31:0] PCPlus4M,

input [31:0] RD,

output RegWriteW,
output [1:0] ResultSrcW,
output [31:0] ALUResultW,
output [31:0] ReadDataW,
output [4:0] RdW,
output [31:0] PCPlus4W
);

    reg RegWriteWr;
    reg [1:0] ResultSrcWr;
    reg [31:0] ALUResultWr, ReadDataWr;
    reg RdWr;
    reg [31:0] PCPlus4Wr;


    always@(posedge CLK) begin 
        RegWriteWr <= RegWriteM; ResultSrcWr <= ResultSrcM; ALUResultWr <= ALUResultM; 
        ReadDataWr <= RD; RdWr <= RdM; PCPlus4Wr <= PCPlus4M;
    end

    assign RegWriteW = RegWriteWr, ResultSrcW = ResultSrcWr, ALUResultW = ALUResultWr;
    assign ReadDataW = ReadDataWr, RdW = RdWr, PCPlus4W = PCPlus4Wr;

endmodule