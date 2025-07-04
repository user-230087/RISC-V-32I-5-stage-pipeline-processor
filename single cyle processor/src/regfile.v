module regfile(input CLK, WE3, 
input [4:0] A1,
input [4:0] A2,
input [4:0] A3,
input [31:0] WD3,
output [31:0] RD1,
output [31:0] RD2
);
    reg [31:0] regFile [31:0];
    always @(posedge CLK)
        if(WE3) regFile[A3] <= WD3;
    assign RD1 = (A1!=0) ? regFile[A1]:0;
    assign RD2 = (A2!=0) ? regFile[A2]:0;

endmodule