`include "../KeyExpansion.v"

module KeyExpansion_tb();

reg [127:0] key128;
wire [0:1279 + 128] fullKeys128;

reg [191:0] key192;
wire [0:1663] fullKeys192;

reg [255:0] key256;
wire [0:1919] fullKeys256;

reg clk;
integer i;
KeyExpansion uut (key128, clk, fullKeys128);

// edit parameter of key expansin
KeyExpansion  #(.Nk(6), .Nb(4), .Nr(12)) uut2(key192, clk, fullKeys192);

KeyExpansion  #(.Nk(8), .Nb(4), .Nr(14)) uut3(key256, clk, fullKeys256);
initial begin
    $dumpfile("KeyExpansion_tb.vcd");
    $dumpvars(0, KeyExpansion_tb);

// key128 = 128'h000102030405060708090a0b0c0d0e0f;
// key192 = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
// key256 = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;

key128 = 128'h2b7e151628aed2a6abf7158809cf4f3c;
key192 = 192'h8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b;
key256 = 256'h603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4;


clk = 1;
#50

$display("words 1 - 4 : %h %h %h %h", uut.words[4], uut.words[5], uut.words[6], uut.words[7]);
$display("words 5 - 8 : %h %h %h %h", uut.words[8], uut.words[9], uut.words[10], uut.words[11]);
$display("Key 1 : %h", fullKeys128[ 0: 127]);
$display("Key 2 : %h", fullKeys128[ 128: 255]);
$display("Last Key : %h\n\n", fullKeys128[1280: 1280 + 127]);

$display("Full key\n %h", fullKeys128);

$display("\n\n192 bit keys\n");

$display("Old words: %h %h %h %h %h %h\n", uut2.words[0], uut2.words[1], uut2.words[2], uut2.words[3], uut2.words[4], uut2.words[5]);
$display("words 6 - 9 : %h %h %h %h", uut2.words[6], uut.words[7], uut.words[8], uut.words[9]);
$display("Key Scheduled : %h %h %h %h\n", uut2.words[4], uut2.words[5], uut2.words[6], uut2.words[7]);
$display("Key 1 : %h", fullKeys192[ 0: 191]);
$display("Key 2 : %h\n\n", fullKeys192[ 192: 192 * 2 - 1]);

$display("Full keys\n%h", fullKeys192);
$display("256 bit keys\n");

$display("words: %h %h %h %h %h %h\n", uut3.words[8], uut3.words[9], uut3.words[10], uut3.words[11], uut3.words[12], uut3.words[13]);
$display("Key 1 : %h", fullKeys256[ 0: 255]);
$display("Key 2 : %h", fullKeys256[ 256 : 256 * 2 - 1]);
#200 $finish;
end

always begin
    #10 clk = ~clk;
end
endmodule