`include "../ShiftRows.v"
module ShiftRows_tb();

reg [127:0] dataIn;
wire [127:0] dataOut;

ShiftRows uut(dataIn, dataOut);

initial begin
    $dumpfile("ShiftRows_tb.vcd");
    $dumpvars(0, ShiftRows_tb);

dataIn = 128'hd42711aee0bf98f1b8b45de51e415230; #10
$finish;
end 
endmodule