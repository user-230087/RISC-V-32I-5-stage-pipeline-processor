module ALU #(parameter N = 32)(
input [N-1:0] SrcA,
input [N-1:0] SrcB,
input [2:0] AluControl,
output reg [N-1:0] AluResult,
output reg Zero
    );
    always @(*)
    begin
        case(AluControl)
        3'b000:begin
        AluResult = SrcA + SrcB;
        Zero = (AluResult == 32'b0);
        end
        3'b001: begin
        AluResult = SrcA - SrcB;
        Zero = (AluResult == 32'b0);
        end 
        3'b011: begin
        AluResult = SrcA | SrcB;
        end
        3'b010: begin
        AluResult = SrcA & SrcB;
        end
        3'b101: begin
        AluResult = SrcA << SrcB;
        end
        3'b110: begin
        AluResult = SrcA < SrcB;
        end
        3'b111: begin
        AluResult = SrcA ^ SrcB;
        end
       default: begin
       AluResult = 32'b0;
       Zero = 1'b0;
       end 
       endcase
    end
endmodule