`include "../GFMulFunctions.v"

module GFMulBy2_tb;
    reg Clk = 0;
    reg [7:0] MulBy2In;
    wire [7:0] MulBy2Out;

    GFMulBy2 uut0(Clk, MulBy2In, MulBy2Out);

    always
    begin
        Clk = !Clk;
        #5;
    end


    initial
    begin
        $dumpfile("GFMulBy2.vcd");
        $dumpvars(0, GFMulBy2_tb);

        $monitor("Time = %0t\nMulBy2In = %0d\nMulBy2Out = %0d\n", $time, MulBy2In, MulBy2Out);
        

        MulBy2In = 8'd123;
        #50;
        MulBy2In = 8'd255;
        #50;
        MulBy2In = 8'd234;
        #50;
        MulBy2In = 8'd23;
        #50;
        
        $finish;
    end 
endmodule

