`include "/home/hos/Eng/logic2/project/AES-128/src/encrypt/AES.v"
`include "/home/hos/Eng/logic2/project/AES-128/src/decrypt/AESDecrypt.v"
module wrapper
(input enable, rst, clk
 output outLed128, outLed192, outLed256);


reg [127:0] dataIn;
// reg [127:0] key;
localparam key128 = 128'h000102030405060708090a0b0c0d0e0f;
localparam key192 = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
localparam key256 = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;

localparam dataIn = 128'h00112233445566778899aabbccddeeff;

reg temp;
wire [127:0] dataOutEncrypted128, dataOutDecrypted128;
wire [127:0] dataOutEncrypted192, dataOutDecrypted192;
wire [127:0] dataOutEncrypted256, dataOutDecrypted256;


AES aes(dataIn, key128, clk, dataOutEncrypted128);
AESDecrypt aesDecrypt(dataOutEncrypted128, key128, clk, dataOutDecrypted128);

AES #(.Nk(6), .Nr(12)) aes192 (dataIn, key192, clk, dataOutEncrypted192);
AESDecrypt #(.Nk(6), .Nr(12)) aesDecrypt192(dataOutEncrypted192, key192, clk, dataOutDecrypted192);


AES #(.Nk(8), .Nr(14)) aes256(dataIn, key256, clk, dataOutEncrypted256);
AESDecrypt #(.Nk(8), .Nr(14)) aesDecrypt256(dataOutEncrypted256, key256, clk, dataOutDecrypted256);


always @(posedge enable) begin
    temp <= 1'b1;
end

always @(posedge clk) begin
if (rst) begin
    outLed128 <= 1'b0;
    outLed192 <= 1'b0;
    outLed256 <= 1'b0;
    temp <= 1'b0;

end else begin
    if (dataOutDecrypted128 == dataIn & temp)
        outLed128 <= 1'b1;
    else
        outLed128 <= 1'b0;


    if (dataOutDecrypted192 == dataIn & temp)
        outLed192 <= 1'b1;
    else
        outLed192 <= 1'b0;

    if (dataOutDecrypted256 == dataIn & temp)
        outLed256 <= 1'b1;
    else
        outLed256 <= 1'b0;
    
end
end

endmodule