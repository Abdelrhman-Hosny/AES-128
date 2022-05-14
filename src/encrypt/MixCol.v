`include "../../util/GFMulFunctions.v"

module MulColEnc(Clk, ColIn, ColOut);
    input Clk;
    input [31:0] ColIn;
    output [31:0] ColOut;

    wire [7:0] MulS0By2Out, MulS1By2Out, MulS2By2Out, MulS3By2Out,
        MulS0By3Out, MulS1By3Out, MulS2By3Out, MulS3By3Out;

    GFMulBy2 tu02(Clk, ColIn[31:24], MulS0By2Out);
    GFMulBy3 tu03(Clk, ColIn[31:24], MulS0By3Out);

    GFMulBy2 tu12(Clk, ColIn[23:16], MulS1By2Out);
    GFMulBy3 tu13(Clk, ColIn[23:16], MulS1By3Out);

    GFMulBy2 tu22(Clk, ColIn[15:8], MulS2By2Out);
    GFMulBy3 tu23(Clk, ColIn[15:8], MulS2By3Out);

    GFMulBy2 tu32(Clk, ColIn[7:0], MulS3By2Out);
    GFMulBy3 tu33(Clk, ColIn[7:0], MulS3By3Out);

    assign ColOut = { (MulS0By2Out ^ MulS1By3Out ^ ColIn[15:8] ^ ColIn[7:0]), 
                   (ColIn[31:24] ^ MulS1By2Out ^ MulS2By3Out ^ ColIn[7:0]) ,
                   (ColIn[31:24] ^ ColIn[23:16] ^ MulS2By2Out ^ MulS3By3Out),
                   (MulS0By3Out ^ ColIn[23:16] ^ ColIn[15:8] ^ MulS3By2Out) };
endmodule


// Takes Only One Cycle To Produce Valid Output 
module MixColEnc(Clk, DataIn, DataOut);
    input Clk;
    input [127:0] DataIn;
    output [127:0] DataOut;

    wire [31:0] MulCol0Out, MulCol1Out, MulCol2Out, MulCol3Out;

    MulColEnc tu0(Clk, DataIn[127:96], MulCol0Out);
    MulColEnc tu1(Clk, DataIn[95:64], MulCol1Out);
    MulColEnc tu2(Clk, DataIn[63:32], MulCol2Out);
    MulColEnc tu3(Clk, DataIn[31:0], MulCol3Out);

    assign DataOut = {MulCol0Out, MulCol1Out, MulCol2Out, MulCol3Out};
endmodule

