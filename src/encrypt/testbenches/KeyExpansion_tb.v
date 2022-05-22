`include "../KeyExpansion.v"

module KeyExpansion_tb();

reg [127:0] key128;
wire [1279:0] fullKeys128;

reg [191:0] key192;
wire [2303:0] fullKeys192;

// reg [255:0] key256;
// wire [3584:0] fullKeys256;

reg clk;
integer i;
KeyExpansion uut (key128, clk, fullKeys128);

// edit parameter of key expansin
KeyExpansion  #(.Nk(6), .Nb(4), .Nr(12)) uut2(key192, clk, fullKeys192);

// KeyExpansion  #(.Nk(8), .Nb(4), .Nr(14)) uut3(key256, clk, fullKeys256);
initial begin
    $dumpfile("KeyExpansion_tb.vcd");
    $dumpvars(0, KeyExpansion_tb);

key128 = 128'h2b7e151628aed2a6abf7158809cf4f3c;
key192 = 192'h8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b;


clk = 1;
#50

$display("words 1 - 4 : %h %h %h %h", uut.words[4], uut.words[5], uut.words[6], uut.words[7]);
$display("words 5 - 8 : %h %h %h %h", uut.words[8], uut.words[9], uut.words[10], uut.words[11]);
$display("Key 1 : %h", fullKeys128[ 127: 0]);
$display("Key 2 : %h", fullKeys128[ 255: 128]);
$display("Last Key : %h", fullKeys128[1279: 1152]);
$display("192 bit keys\n\n\n");

$display("Old words: %h %h %h %h %h %h\n", uut2.words[0], uut2.words[1], uut2.words[2], uut2.words[3], uut2.words[4], uut2.words[5]);
$display("words 6 - 9 : %h %h %h %h", uut2.words[6], uut.words[7], uut.words[8], uut.words[9]);
$display("Key 1 : %h", fullKeys192[ 191: 0]);
$display("Key 2 : %h", fullKeys192[ 192 * 2 - 1: 192]);

$display("rcon : %h", uut2.rcon);
#200 $finish;
end

always begin
    #10 clk = ~clk;
end
endmodule