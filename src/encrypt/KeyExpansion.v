`include "../SBytes.v"

module KeyExpansion
        # (parameter Nk = 4,
            parameter Nr = 10,
            parameter Nb = 4
            )
            (input [Nk * 32 - 1:0] keyIn, input clk,
                   output reg [0: (Nr + 1) * Nk * 32 - 1] keyOut);

// random constant definition
wire [0:319] rcon;
generate
    if (Nk == 4)
        assign rcon = 320'h01_00_00_00_02_00_00_00_04_00_00_00_08_00_00_00_10_00_00_00_20_00_00_00_40_00_00_00_80_00_00_00_1b_00_00_00_36_00_00_00;
    else if (Nk == 6)
        assign rcon[0: 255] = 256'h01_00_00_00_02_00_00_0004_00_00_0008_00_00_0010_00_00_0020_00_00_0040_00_00_0080_00_00_00;

    else if (Nk == 8)
        assign rcon[0: 223] = 224'h01_00_00_00_02_00_00_00_04_00_00_00_08_00_00_00_10_00_00_00_20_00_00_00_40_00_00_00;

endgenerate

wire [31:0] words [0: Nk * (Nr + 1) - 1];
wire [31:0] temp[0:Nr - 1];
genvar i, rNum, j, k, inKey, t2_gen;

    wire [31:0] temp2[0:5];



// assign input key to words 0 -> Nk - 1
// works
generate
    for (i = 0; i < Nk; i = i + 1) begin
        assign words[i] = keyIn[(Nk - 1 - i)*32 + 31:(Nk - 1 -i)*32];
    end
endgenerate

// set the temp for each time j % 4 == 0 
generate
    for (rNum = 1; rNum < (Nr + 1); rNum = rNum + 1) begin
        SBytes #(.NWords(1)) SBytes_block({words[rNum * Nk - 1][23:0],words[rNum * Nk - 1][31:24]}, temp[rNum - 1]);
    end
endgenerate

generate
    if (Nk == 8) begin
    for (t2_gen = 12; t2_gen < 53; t2_gen = t2_gen + 8) begin
        SBytes #(.NWords(1)) SBytes_block(words[t2_gen - 1], temp2[t2_gen/8 - 1]);
    end
    end
endgenerate

// generate the words
generate
    for (j = Nk; j < Nb * (Nr + 1); j = j + 1) begin

            if (j % Nk == 0)

                assign words[j] = words[j - Nk] ^  rcon[(j/Nk - 1) * 32: (j/Nk - 1) * 32 + 31] ^ temp[(j - Nk)/Nk];
                        
            else if (Nk > 6 && j % Nk == 4)
                assign words[j] = words[j - Nk] ^ temp2[j/Nk - 1];

            else
                assign words[j] = words[j - Nk] ^ words[j - 1];
            
        end

endgenerate

// generate
//     for (j = Nk; j < Nb * (Nr + 1); j = j + 1) begin
//         assign words[j] = (j % Nk == 0) ? words[j - 4] ^ rcon[(j/4 - 1) * 32: (j/4 - 1) * 32 + 31] ^ temp[(j - 4)/4]: words[j - 4] ^ words[j - 1] ;
//     end
// endgenerate



// at each clock, output all keys
// key1 = keyOut[Nk * keyWidth - 1: 0]

// key2 = keyOut[2 * Nk * keyWidth - 1: Nk * keyWidth]
always @(posedge clk) begin
    keyOut[0: Nk * 32 - 1] = keyIn;
end
generate
    for (k = 0; k < Nr; k = k + 1) begin
        for (inKey = 0; inKey < Nk; inKey = inKey + 1) begin
            always @(posedge clk ) begin
                keyOut[ (k + 1) * Nk * 32 + (inKey) * 32:
                        (k + 1) * Nk * 32 + (inKey + 1) * 32 - 1] = words[k * Nk + inKey + Nk];
            end
        end
    end
endgenerate
endmodule