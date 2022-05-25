`include "AESFull.v"

module AESFull_tb();

reg sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7;
reg clk = 0;
reg rst;
reg pushBtn = 0;
wire ledOut;

AESFull uut(sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, 
            pushBtn,
            clk,  rst,
            ledOut);

always begin
    #10 clk = ~clk;
end

initial begin

rst=1;
pushBtn = 1; #10 pushBtn = 0;
rst = 0;
#10;
$monitor("Counter : %d, LED : %b\ndataIn : %h\n", uut.outCounter, uut.ledOut, uut.dataIn);

{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;

pushBtn = 1; #10 pushBtn = 0;


{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;
pushBtn = 1; #10 pushBtn = 0;

{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;
pushBtn = 1; #10 pushBtn = 0;


{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;
pushBtn = 1; #10 pushBtn = 0;


{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;
pushBtn = 1; #10 pushBtn = 0;


{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;
pushBtn = 1; #10 pushBtn = 0;


{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;

pushBtn = 1; #10 pushBtn = 0;


{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;
pushBtn = 1; #10 pushBtn = 0;

{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;
pushBtn = 1; #10 pushBtn = 0;


{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;
pushBtn = 1; #10 pushBtn = 0;


{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;
pushBtn = 1; #10 pushBtn = 0;


{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;
pushBtn = 1; #10 pushBtn = 0;


{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;

pushBtn = 1; #10 pushBtn = 0;


{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;
pushBtn = 1; #10 pushBtn = 0;

{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;
pushBtn = 1; #10 pushBtn = 0;


{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;
pushBtn = 1; #10 pushBtn = 0;


{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;
pushBtn = 1; #10 pushBtn = 0;


{sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7} = 8'b00000000;
pushBtn = 1; #10 pushBtn = 0;



#20;
$display("Testbench for AESFull");

#2201

$display("AES\n");
$display("%h\n", uut.aes.state[5]);
$display("Data In : %h\n", uut.dataIn);
$display("Data Encrypted : %h\n", uut.dataOutEncrypted);
$display("Data Decrypted : %h\n", uut.dataOutDecrypted);

$finish;
end

endmodule