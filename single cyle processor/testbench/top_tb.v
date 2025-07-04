module top_tb;

    reg clk, reset;
    wire [31:0] WriteData, DataAddr;
    wire MemWrite;
    
    top dut(clk, reset, WriteData, DataAddr, MemWrite);
    
    initial begin
    reset <= 1; #22; reset <= 0;
    end
    
    always begin 
        clk <= 1; #5; clk <= 0; #5;
    end
    
    always @(negedge clk)
    begin
        if(MemWrite) begin 
            if(DataAddr === 100 & WriteData === 25) begin
                $display("Simulation succeeded");
                $stop;
            end
            else if (DataAddr !== 96) begin
                $display("Simulation Failed");
                $stop;
            end
         end
    end
endmodule