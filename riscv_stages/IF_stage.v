module IF_stage(input [31:0] PCTargetE,
input CLK, Reset, PCSrcE, StallF, EN, Clr,
input [31:0] Instr,
output [31:0] InstrD,
output [31:0] PC_o,
output [31:0] PCPlus4F_o,
output [31:0] PCF);

    wire [31:0] PCPlus4;
    wire [31:0] PCF_1;
    reg [31:0] Instr_reg, PCreg, PCplus4freg;

    mux2 muxpc(PCTargetE, PCPlus4, PCSrcE);
    Adder PCplus4(PCF, 32'd4, PCPlus4);
    flopr PCff(CLK, Reset, PCF_1, PCF);

    always @(posedge CLK, negedge Clr) begin 
        if(!Clr) begin 
            Instr_reg <= 32'b0;
            PCreg <= 32'b0;
            PCplus4freg <= 32'b0;
        end
        else begin 
            Instr_reg <= Instr;
            PCreg <= PCF;
            PCplus4freg <= PCPlus4;
        end
    end

    assign InstrD = Instr_reg, PC_o = PCreg, PCPlus4F_o = PCplus4freg;

endmodule

// module mux_2x1(
// input [31:0] A,B,
// input sel, 
// output [31:0] C 
//     );
//     assign C = (sel) ? A:B;
// endmodule

// module flopr #(parameter WIDTH = 32) (
// input CLK, rst,
// input [WIDTH-1:0] d,
// output reg [WIDTH-1:0] Q
//     );
//     always @(posedge CLK, posedge rst)
//     begin 
//     if(rst) Q <= 8'b0;
//     else Q <= d;
//     end
// endmodule
