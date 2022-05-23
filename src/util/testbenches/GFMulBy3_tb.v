`include "../GFMulFunctions.v"

module GFMulBy3_tb;
    reg Clk = 0;
    reg [7:0] MulIn;
    wire [7:0] MulOut;

    GFMulBy3 uut0(Clk, MulIn, MulOut);

    always
    begin
        Clk = !Clk;
        #5;
    end


    initial
    begin
        $dumpfile("GFMulBy3.vcd");
        $dumpvars(0, GFMulBy3_tb);

        $monitor("Time = %0t\nMulBy2In = %0d\nMulBy2Out = %0d\n", $time, MulIn, MulOut);
        

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

