// `include "../AddRoundKey.v"
// `include "../KeyExpansion.v"
// `include "../ShiftRows.v"
// `include "../MixCol.v"
// `include "../SBytes.v"

module AES
    #(
        parameter Nk=4,
        parameter Nr=10,
        parameter Nb=4
    )
    (input [127:0] dataIn, input [Nk * 32 - 1:0] keyIn, input clk,
    output [127:0] dataOut);
    
    genvar i;
    wire [127:0] state [0:Nr];
    wire [127:0] outSBytes [0:Nr];
    wire [127:0] outShiftRows [0:Nr];
    wire [127:0] outMixCol [0:Nr];
    wire [0 :(Nr + 1) * Nb * 32 - 1] keysOut;

    AddRoundKey addRoundKey(dataIn, keysOut[0:127], state[0]);

    KeyExpansion #(.Nk(Nk), .Nr(Nr)) keyExpansion(keyIn, clk, keysOut);
    generate

        for (i = 0; i < Nr; i = i + 1) begin : aeslabel1

            SBytes #(.NWords(4)) sBytes (clk,state[i], outSBytes[i]);
            ShiftRows shiftRows(outSBytes[i], outShiftRows[i]);
            MixColEnc mixCol(clk, outShiftRows[i], outMixCol[i]);
            AddRoundKey addRoundKey(outMixCol[i], keysOut[(i + 1) * 128: (i + 1) * 128 + 127], state[i + 1]);
        end
    endgenerate

    SBytes #(.NWords(4)) finalSBytes (clk,state[Nr - 1], outSBytes[Nr]);
    ShiftRows finalShiftRows(outSBytes[Nr], outShiftRows[Nr]);
    AddRoundKey finalAddRoundKey(outShiftRows[Nr],keysOut[(Nr) * 128: (Nr) * 128 + 127], dataOut);


endmodule