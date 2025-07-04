module flopr #(parameter WIDTH = 8) (
input CLK, reset,
input [WIDTH-1:0] d,
output reg [WIDTH-1:0] Q
    );
    always @(posedge CLK, posedge reset)
    begin 
    if(reset) Q <= 8'b0;
    else Q <= d;
    end
endmodule