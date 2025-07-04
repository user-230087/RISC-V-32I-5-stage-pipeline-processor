module top(
input CLK, reset,
output [31:0] WriteData, DataAddr,
output MemWrite
    );
    
    wire [31:0] PC, Instr, ReadData;
    
    riscvsingle riscv(CLK, reset, PC, Instr, MemWrite, DataAddr, WriteData, ReadData);
    imem imem(PC, Instr);
    dmem dmem(CLK, MemWrite, DataAddr, WriteData, ReadData);
endmodule