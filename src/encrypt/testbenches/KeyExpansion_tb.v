`include "../KeyExpansion.v"

module KeyExpansion_tb();

reg [127:0] key;
wire [1279:0] fullKeys;
reg clk;
integer i;
KeyExpansion uut (key, clk, fullKeys);
initial begin
    $dumpfile("KeyExpansion_tb.vcd");
    $dumpvars(0, KeyExpansion_tb);

key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
clk = 1;
#50

$display("words 1 - 4 : %h %h %h %h", uut.words[4], uut.words[5], uut.words[6], uut.words[7]);
$display("words 5 - 8 : %h %h %h %h", uut.words[8], uut.words[9], uut.words[10], uut.words[11]);
$display("Key 1 : %h", fullKeys[ 127: 0]);
$display("Key 2 : %h", fullKeys[ 255: 128]);
    
#200 $finish;
end

always begin
    #10 clk = ~clk;
end
endmodule