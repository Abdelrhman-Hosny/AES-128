`include "../InvShiftRows.v"
`include "../../encrypt/KeyExpansion.v"
`include "../../encrypt/AddRoundKey.v"
`include "../InvMixCol.v"
`include "../InvSBytes.v"


module AESDecrypt
    #(
        parameter Nk=4,
        parameter Nr=10,
        parameter Nb=4
    )
    (input [127:0] dataIn, input [Nk * 32 - 1:0] keyIn, input clk,
    output [127:0] dataOut);
 
    genvar i;

    wire [127:0] state [0: Nr - 1];
    wire [127:0] outSBytes [0:Nr - 1];
    wire [127:0] outShiftRows [0:Nr - 1];
    wire [127:0] outMixCol [0:Nr - 1];
    wire [0 :(Nr + 1) * Nb * 32 - 1] keysOut;

    KeyExpansion #(.Nk(Nk), .Nr(Nr)) keyExpansion(keyIn, clk, keysOut);
    AddRoundKey firstAddRoundKey (
        dataIn,
        keysOut[(Nr + 1) * 128 - 128: (Nr + 1) * 128 - 1],
        outMixCol[Nr - 1]
    );


    for (i = Nr - 1; i > 0; i = i - 1) begin
        InvShiftRows invShiftRows (
            outMixCol[i],
            outShiftRows[i]
        );

        InvSBytes invSBytes (
            outShiftRows[i],
            outSBytes[i]);

        AddRoundKey addRoundKey (
            outSBytes[i],
            keysOut[(i) * 128: (i) * 128 + 127],
            state[i]
        );

        MixColDec invMixCol (
            clk,
            state[i],
            outMixCol[i - 1]
        );
    end

    InvShiftRows invShiftRows (
        outMixCol[0],
        outShiftRows[0]
    );

    InvSBytes finalInvSBytes (
        outShiftRows[0],
        outSBytes[0]
    );

    AddRoundKey addRoundKey (
        outSBytes[0],
        keysOut[0: 127],
        dataOut
    );

endmodule