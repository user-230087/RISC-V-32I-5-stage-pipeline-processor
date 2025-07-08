module WB_stage( input CLK,
input [1:0] ResultSrcW,
input [31:0] ALUResultW,
input [31:0] ReadDataW,
input [4:0] RdW,
input [31:0] PCPlus4W,
output [31:0] ResultW
);

mux3 muxsel(ALUResultW, ReadDataW, PCPlus4W, ResultSrcW, ResultW);
endmodule