`include "../../util/GFMulFunctions.v"

module MulColDec(Clk, ColIn, ColOut);
    input Clk;
    input [31:0] ColIn;
    output [31:0] ColOut;

    wire [7:0] MulS0ByEOut, MulS0ByBOut, MulS0ByDOut, MulS0By9Out,
               MulS1ByEOut, MulS1ByBOut, MulS1ByDOut, MulS1By9Out,
               MulS2ByEOut, MulS2ByBOut, MulS2ByDOut, MulS2By9Out,
               MulS3ByEOut, MulS3ByBOut, MulS3ByDOut, MulS3By9Out;

    GFMulBy9   tu09(Clk, ColIn[31:24], MulS0By9Out);
    GFMulBy0xB tu0b(Clk, ColIn[31:24], MulS0ByBOut);
    GFMulBy0xD tu0d(Clk, ColIn[31:24], MulS0ByDOut);
    GFMulBy0xE tu0e(Clk, ColIn[31:24], MulS0ByEOut);

    GFMulBy9   tu19(Clk, ColIn[23:16], MulS1By9Out);
    GFMulBy0xB tu1b(Clk, ColIn[23:16], MulS1ByBOut);
    GFMulBy0xD tu1d(Clk, ColIn[23:16], MulS1ByDOut);
    GFMulBy0xE tu1e(Clk, ColIn[23:16], MulS1ByEOut);

    GFMulBy9   tu29(Clk, ColIn[15:8], MulS2By9Out);
    GFMulBy0xB tu2b(Clk, ColIn[15:8], MulS2ByBOut);
    GFMulBy0xD tu2d(Clk, ColIn[15:8], MulS2ByDOut);
    GFMulBy0xE tu2e(Clk, ColIn[15:8], MulS2ByEOut);

    GFMulBy9   tu39(Clk, ColIn[7:0], MulS3By9Out);
    GFMulBy0xB tu3b(Clk, ColIn[7:0], MulS3ByBOut);
    GFMulBy0xD tu3d(Clk, ColIn[7:0], MulS3ByDOut);
    GFMulBy0xE tu3e(Clk, ColIn[7:0], MulS3ByEOut);

    assign ColOut = { MulS0ByEOut ^ MulS1ByBOut ^ MulS2ByDOut ^ MulS3By9Out,
                      MulS0By9Out ^ MulS1ByEOut ^ MulS2ByBOut ^ MulS3ByDOut,
                      MulS0ByDOut ^ MulS1By9Out ^ MulS2ByEOut ^ MulS3ByBOut,
                      MulS0ByBOut ^ MulS1ByDOut ^ MulS2By9Out ^ MulS3ByEOut };
endmodule

// Takes 3 Cycles to produce Valid Output
module MixColDec(Clk, DataIn, DataOut);
    input Clk;
    input [127:0] DataIn;
    output [127:0] DataOut;

    wire [31:0] MulCol0Out, MulCol1Out, MulCol2Out, MulCol3Out;

    MulColDec tu0(Clk, DataIn[127:96], MulCol0Out);
    MulColDec tu1(Clk, DataIn[95:64] , MulCol1Out);
    MulColDec tu2(Clk, DataIn[63:32] , MulCol2Out);
    MulColDec tu3(Clk, DataIn[31:0]  , MulCol3Out);

    assign DataOut = {MulCol0Out, MulCol1Out, MulCol2Out, MulCol3Out};
endmodule

