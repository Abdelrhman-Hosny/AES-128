`include "../GFMulFunctions.v"

module GFMulFunctions_tb;
    reg Clk = 0;
    reg [7:0] MulIn;
    wire [7:0] MulOut4, MulOut8, MulOut9, MulOutB, MulOutD, MulOutE;

    GFMulBy4 uut0(Clk, MulIn, MulOut4);
    GFMulBy8 uut1(Clk, MulIn, MulOut8);
    GFMulBy9 uut2(Clk, MulIn, MulOut9);
    GFMulBy0xB uut3(Clk, MulIn, MulOutB);
    GFMulBy0xD uut4(Clk, MulIn, MulOutD);
    GFMulBy0xE uut5(Clk, MulIn, MulOutE);

    always
    begin
        Clk = !Clk;
        #5;
    end


    initial
    begin
        $dumpfile("GFMulFunctions.vcd");
        $dumpvars(0, GFMulFunctions_tb);

        //$monitor("[Mul By 4]\nTime = %0t\nMulIn = %0d\nMulOut = %0d\n", $time, MulIn, MulOut4);
        //$monitor("[Mul By 8]\nTime = %0t\nMulIn = %0d\nMulOut = %0d\n", $time, MulIn, MulOut8);
        //$monitor("[Mul By 9]\nTime = %0t\nMulIn = %0d\nMulOut = %0d\n", $time, MulIn, MulOut9);
        //$monitor("[Mul By B]\nTime = %0t\nMulIn = %0d\nMulOut = %0d\n", $time, MulIn, MulOutB);
        //$monitor("[Mul By D]\nTime = %0t\nMulIn = %0d\nMulOut = %0d\n", $time, MulIn, MulOutD);
        $monitor("[Mul By E]\nTime = %0t\nMulIn = %0d\nMulOut = %0d\n", $time, MulIn, MulOutE);
        

        MulIn = 8'd123;
        #50;
        MulIn = 8'd255;
        #50;
        MulIn = 8'd234;
        #50;
        MulIn = 8'd23;
        #50;
        
        $finish;
    end 
endmodule

