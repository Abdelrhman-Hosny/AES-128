`include "../SBytes.v"
module KeyExpansion(input [127:0] keyIn, input clk,
                   output reg [127:0] key1, key2, key3, key4, key5, key6, key7, key8, key9, key10);


// random constant definition
reg [0:319] rcon = 320'h01_00_00_00_02_00_00_0004_00_00_0008_00_00_0010_00_00_0020_00_00_0040_00_00_0080_00_00_001b_00_00_0036_00_00_00;

wire [31:0] words [0:43];
reg [31:0] word, word1, word2, word3, word4, word5, word6, word7, word8, word9, word10;
wire [31:0] temp[0:9];
genvar i, rNum, j;

// assign input key to words 0 -> 3
generate
    for (i = 0; i < 4; i = i + 1) begin
        assign words[i] = keyIn[(3 - i)*32 + 31:(3 -i)*32];
    end
endgenerate

// set the temp for each time j % 4 == 0 
generate
    for (rNum = 1; rNum < 11; rNum = rNum + 1) begin
        SBytes #(.NWords(1)) SBytes_block({words[rNum * 4 - 1][23:0],words[rNum * 4 - 1][31:24]}, temp[rNum - 1]);
    end
endgenerate

// generate the words
generate
    for (j = 4; j < 44; j = j + 1) begin
        assign words[j] = (j % 4 == 0) ? words[j - 4] ^ rcon[(j/4 - 1) * 32: (j/4 - 1) * 32 + 31] ^ temp[(j - 4)/4]: words[j - 4] ^ words[j - 1] ;
    end
endgenerate

// at each clock, output all keys
always @(posedge clk ) begin
    key1 = { words[4 + 3], words[4 + 2], words[4 + 1], words[4] };
    key2 = { words[8 + 3], words[8 + 2], words[8 + 1], words[8] };
    key3 = { words[12 + 3], words[12 + 2], words[12 + 1], words[12] };
    key4 = { words[16 + 3], words[16 + 2], words[16 + 1], words[16] };
    key5 = { words[20 + 3], words[20 + 2], words[20 + 1], words[20] };
    key6 = { words[24 + 3], words[24 + 2], words[24 + 1], words[24] };
    key7 = { words[28 + 3], words[28 + 2], words[28 + 1], words[28] };
    key8 = { words[32 + 3], words[32 + 2], words[32 + 1], words[32] };
    key9 = { words[36 + 3], words[36 + 2], words[36 + 1], words[36] };
    key10 = { words[40 + 3], words[40 + 2], words[40 + 1], words[40] };
end


endmodule