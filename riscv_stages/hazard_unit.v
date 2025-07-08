module hazard_unit(
    output StallF, StallD, FlushD, FlushE,
    output [1:0] ForwardAE, ForwardBE,
    input [4:0] Rs1D, Rs2D, 
    input [4:0] RdE, Rs2E, Rs1E, RdM, RdW,
    input PCSrcE, RegWriteM, RegWriteW,
    input [1:0] ResultSrcE
);
    reg [1:0] ForwardAEr;
    assign ForwardAE = ForwardAEr;

    wire lwStall;

    always@(*) begin 
        if  (((Rs1E == RdM) & RegWriteM) & (Rs1E != 0)) 
        ForwardAEr = 2'b10;
        else if (((Rs1E == RdW) & RegWriteW) & (Rs1E != 0))
        ForwardAEr = 2'b01;
        else            
        ForwardAEr = 2'b00;
    end

    assign  lwStall = (ResultSrcE & ((Rs1D == RdE) | (Rs2D == RdE))), StallF = lwStall, StallD  = lwStall;
    assign FlushD = PCSrcE, FlushE  = lwStall | PCSrcE;
endmodule