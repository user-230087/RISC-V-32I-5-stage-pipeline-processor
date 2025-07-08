module controller(
input [6:0] op,
input [2:0] funct3,
input funct7,
input zero,
output [1:0] ResultSrc,
output MemWrite,
output PCSrc, ALUSrc,
output RegWrite, Jump,
output [1:0] ImmSrc,
output [2:0] ALUControl
    );
    wire [1:0] ALUop;
    wire branch;
    maindec M(op, ResultSrc, MemWrite, branch, ALUSrc, RegWrite, Jump, ImmSrc, ALUop);
    ALUDec A(op[5], funct3, funct7, ALUop, ALUControl);
    
    assign PCSrc = zero & branch | Jump;
endmodule