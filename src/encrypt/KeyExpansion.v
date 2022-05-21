`include "../SBytes.v"

module KeyExpansion
        # (parameter Nk = 4,
            parameter Nr = 10,
            parameter Nb = 4
            )
            (input [Nk * 32 - 1:0] keyIn, input clk,
                   output reg [ Nr * Nk * 32 - 1:0] keyOut);

// random constant definition
reg [0:319] rcon = 320'h01_00_00_00_02_00_00_0004_00_00_0008_00_00_0010_00_00_0020_00_00_0040_00_00_0080_00_00_001b_00_00_0036_00_00_00;

wire [31:0] words [0: Nb * (Nr + 1) - 1];
wire [31:0] temp[0:9];
genvar i, rNum, j, k, inKey;



// assign input key to words 0 -> Nk - 1
generate
    for (i = 0; i < Nk; i = i + 1) begin
        assign words[i] = keyIn[(Nk - 1 - i)*32 + 31:(Nk - 1 -i)*32];
    end
endgenerate

// set the temp for each time j % 4 == 0 
generate
    for (rNum = 1; rNum < (Nr + 1); rNum = rNum + 1) begin
        SBytes #(.NWords(1)) SBytes_block({words[rNum * 4 - 1][23:0],words[rNum * 4 - 1][31:24]}, temp[rNum - 1]);
    end
endgenerate

// generate the words
generate
    for (j = Nk; j < Nk * (Nr + 1); j = j + 1) begin
        assign words[j] = (j % 4 == 0) ? words[j - 4] ^ rcon[(j/4 - 1) * 32: (j/4 - 1) * 32 + 31] ^ temp[(j - 4)/4]: words[j - 4] ^ words[j - 1] ;
    end
endgenerate

// at each clock, output all keys
// key1 = keyOut[Nk * keyWidth - 1: 0]

// key2 = keyOut[2 * Nk * keyWidth - 1: Nk * keyWidth]
generate
    for (k = 0; k < Nr; k = k + 1) begin
        for (inKey = 0; inKey < Nk; inKey = inKey + 1) begin
            always @(posedge clk ) begin
                keyOut[ k * Nk * 32 + (inKey + 1) * 32 - 1:
                        k * Nk * 32 + (inKey) * 32] = words[k * Nk + (Nk - 1 - inKey) + Nk];
            end
        end
    end
endgenerate
endmodule