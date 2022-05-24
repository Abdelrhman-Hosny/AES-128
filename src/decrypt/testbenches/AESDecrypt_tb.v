`include "../AESDecrypt.v"

module AESDecrypt_tb();


reg [127:0] dataIn, dataIn192, dataIn256;
reg [127:0] key;
reg [191:0] key192;
reg [255:0] key256;
reg clk = 0;
wire [127:0] dataOut, dataOut192, dataOut256;
AESDecrypt aesDecrypt(dataIn, key, clk, dataOut);
genvar i;
AESDecrypt #(.Nk(6), .Nr(12)) aesDecrypt192(dataIn192, key192, clk, dataOut192);
AESDecrypt #(.Nk(8), .Nr(14)) aesDecrypt256(dataIn256, key256, clk, dataOut256);
always begin
    #10 clk = ~clk;
end
initial begin

dataIn = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
key = 128'h000102030405060708090a0b0c0d0e0f;

dataIn192 = 128'hdda97ca4864cdfe06eaf70a0ec0d7191;
key192 = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;

dataIn256 = 128'h8ea2b7ca516745bfeafc49904b496089 ;
key256 = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f ;

#10000;
$display("First InvMixCol : %h\n", aesDecrypt.outMixCol[9]);


$display("Second InvShiftRow : %h\n", aesDecrypt.outShiftRows[9]);
$display("Second InvSubBytes : %h\n", aesDecrypt.outSBytes[9]);
$display("Second RoundKey : %h\n", aesDecrypt.state[9]);
$display("Second InvCol : %h\n", aesDecrypt.outMixCol[8]);

$display("bef InvCol : %h\n", aesDecrypt.outMixCol[1]);
$display("Last InvCol : %h\n", aesDecrypt.outMixCol[0]);
$display("dataOut : %h\n", dataOut);

// $display("Key 1 : %h\n",  aesDecrypt.keysOut[0 * 128: 0 * 128 + 127]);
// $display("Key 1 : %h\n",  aesDecrypt.keysOut[1 * 128: 1 * 128 + 127]);
// $display("Key 1 : %h\n",  aesDecrypt.keysOut[2 * 128: 2 * 128 + 127]);
// $display("Key 1 : %h\n",  aesDecrypt.keysOut[3 * 128: 3 * 128 + 127]);

$display("dataOut : %h\n", dataOut192);
$display("dataOut : %h\n", dataOut256);


$finish;
end

endmodule