`include "/home/hos/Eng/logic2/project/AES-128/src/encrypt/AES.v"
`include "/home/hos/Eng/logic2/project/AES-128/src/decrypt/AESDecrypt.v"

module Counter(input clk, rst,
                output reg [4:0] out);

    always @(posedge clk) begin
        if (rst) begin
            out <= 0;
        
        end else if (out > 5'd17) begin
            out <= 0;
        
        end else begin
            out <= out + 1;
        end
    end

endmodule

module AESFull
(input sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7,
                input inputPushButton,
                input clk, rst,
                output reg ledOut
                );


wire [4:0] outCounter;
reg [127:0] dataIn;
// reg [127:0] key;
localparam key = 128'h000102030405060708090a0b0c0d0e0f;
wire [127:0] dataOutEncrypted, dataOutDecrypted;

Counter counter(inputPushButton, rst, outCounter);

AES aes(dataIn, key, clk, dataOutEncrypted);
AESDecrypt aesDecrypt(dataOutEncrypted, key, clk, dataOutDecrypted);


always @(posedge inputPushButton ) begin
    if (outCounter == 5'd1)
        dataIn[7:0] <= {sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7};
    else if (outCounter < 5'd17) begin
        dataIn[127:0] <= {dataIn[7:0], dataIn[127:8]};
        dataIn[ 7: 0] <= {sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7};

    end else begin
        dataIn <= dataIn;
    end
end

always @(posedge clk ) begin
    if (outCounter == 5'd18) 
        if (dataIn == dataOutDecrypted)
            ledOut <= 1;
        else
            ledOut <= 0;
    else
        ledOut <= 0;
end

    


endmodule