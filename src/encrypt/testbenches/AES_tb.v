`include "../AES.v"

module AES_tb();

reg [127:0] dataIn, dataIn192, dataIn256;
reg [127:0] key;
reg [191:0] key192;
reg [255:0] key256;
reg clk = 0;
wire [127:0] dataOut, dataOut192, dataOut256;
AES aes(dataIn, key, clk, dataOut);

AES #(.Nk(6), .Nr(12)) aes192(dataIn192, key192, clk, dataOut192);
AES #(.Nk(8), .Nr(14)) aes256(dataIn256, key256, clk, dataOut256);
always begin
    #10 clk = ~clk;
end

initial begin
dataIn =  128'h00112233445566778899aabbccddeeff;
key = 128'h000102030405060708090a0b0c0d0e0f;

dataIn192 = 128'h00112233445566778899aabbccddeeff;
key192 = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;

dataIn256 = 128'h00112233445566778899aabbccddeeff;
key256 = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;


#1000

$display("AES 128");
$display("Last State : %h", aes.state[9]);
$display("Last Sbytes : %h", aes.outSBytes[9]);
$display("Last ShiftRows : %h", aes.outShiftRows[9]);
$display("DataOut : %h", dataOut);

$display("AES 192");


$display("State 0 : %h", aes192.state[0]);
$display("State 1 : %h", aes192.state[1]);
$display("First Sbytes : %h", aes192.outSBytes[0]);
$display("First ShiftRows : %h", aes192.outShiftRows[0]);
$display("First column : %h", aes192.outMixCol[0]);
$display("DataOut : %h", dataOut192);

$display("AES 256");
// $display("State 0 : %h", aes256.state[0]);
$display("Last State : %h", aes256.state[13]);
$display("First Sbytes : %h", aes256.outSBytes[13]);
$display("First ShiftRows : %h", aes256.outShiftRows[13]);
$display("DataOut : %h", dataOut256);


$finish;

end
endmodule