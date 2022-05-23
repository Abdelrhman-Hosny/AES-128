`include "../AES.v"

module AES_tb();

reg [127:0] key, dataIn;
reg clk = 0;
wire [127:0] dataOut;
AES aes(dataIn, key, clk, dataOut);

always begin
    #10 clk = ~clk;
end

initial begin
dataIn =  128'h3243f6a8885a308d313198a2e0370734;
key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
#400

$display("First Add Round Key : %h", aes.state[0]);
$display("First Sbytes : %h", aes.outSBytes[0]);
$display("First ShiftRows : %h", aes.outShiftRows[0]);
$display("First MixCol : %h", aes.outMixCol[0]);

$display("Second Add Round Key : %h", aes.state[1]);
$display("Second Sbytes : %h", aes.outSBytes[1]);
$display("Second ShiftRows : %h", aes.outShiftRows[1]);
$display("Second MixCol : %h", aes.outMixCol[1]);

$display("Last State : %h", aes.state[9]);
$display("Last Sbytes : %h", aes.outSBytes[9]);
$display("Last ShiftRows : %h", aes.outShiftRows[9]);
$display("DataOut : %h", dataOut);
$finish;

end
endmodule