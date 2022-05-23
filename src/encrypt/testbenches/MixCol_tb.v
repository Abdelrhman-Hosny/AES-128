`include "../MixCol.v"

module MixCol_tb;
    reg [127:0] In;
    reg Clk = 0;
    wire [127:0] Out;


    MixColEnc uut(Clk, In, Out);

    always
    begin
        Clk = !Clk;
        #5;
    end
    

    initial
    begin

        $dumpfile("MixCol_tb.vcd");
        $dumpvars(0, MixCol_tb);
        $monitor("Time = %0t\nIn = 0x%0h\nOut = 0x%0h\n", $time, In, Out);

        In = 128'h6353e08c0960e104cd70b751bacad0e7;
        #30;
        In = 128'ha7be1a6997ad739bd8c9ca451f618b61;
        #30;
        In = 128'h3bd92268fc74fb735767cbe0c0590e2d;
        #30;
        In = 128'h2d6d7ef03f33e334093602dd5bfb12c7;
        #30
        $finish;
    end
endmodule
