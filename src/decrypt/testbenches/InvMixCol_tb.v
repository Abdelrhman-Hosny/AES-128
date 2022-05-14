`include "../InvMixCol.v"

module InvMixCol_tb;
    reg [127:0] In;
    reg Clk = 0;
    wire [127:0] Out;


    MixColDec uut(Clk, In, Out);

    always
    begin
        Clk = !Clk;
        #5;
    end
    

    initial
    begin

        $dumpfile("InvMixCol_tb.vcd");
        $dumpvars(0, InvMixCol_tb);
        $monitor("Time = %0t\nIn = 0x%0h\nOut = 0x%0h\n", $time, In, Out);

        In = 128'hbd6e7c3df2b5779e0b61216e8b10b689;
        #50;
        In = 128'hfde3bad205e5d0d73547964ef1fe37f1;
        #50;
        In = 128'hd1876c0f79c4300ab45594add66ff41f;
        #50;
        In = 128'hc62fe109f75eedc3cc79395d84f9cf5d;
        #50
        $finish;
    end
endmodule
