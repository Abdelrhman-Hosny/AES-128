`include "../KeyExpansion.v"

module KeyExpansion_tb();

reg [127:0] key;
wire [127:0] key1, key2, key3, key4, key5, key6, key7, key8, key9, key10;
reg clk;
initial begin
    $dumpfile("KeyExpansion_tb.vcd");
    $dumpvars(0, KeyExpansion_tb);

key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
clk = 1;
#200 $finish;
end

always begin
    #10 clk = ~clk;
end
KeyExpansion uut (key, clk, key1, key2, key3, key4, key5, key6, key7, key8, key9, key10);
endmodule