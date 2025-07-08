module ALUDec(
input op5,
input [2:0] funct3,
input funct7,
input [1:0] aluop,
output reg [2:0] ALUcontrol
    );
    wire RtypeSub;
    assign RtypeSub = funct7 & op5;
    always @(*)
    case(aluop)
    2'b00: ALUcontrol = 3'b000;
    2'b01: ALUcontrol = 3'b001;
    default: case(funct3)
         3'b000: if(RtypeSub)
                    ALUcontrol = 3'b001;
                 else
                    ALUcontrol = 3'b000;
          3'b010: ALUcontrol = 3'b110;
          3'b110: ALUcontrol = 3'b011;
          3'b111: ALUcontrol = 3'b010;
          default: ALUcontrol = 3'bxxx;
          endcase
    endcase

endmodule
