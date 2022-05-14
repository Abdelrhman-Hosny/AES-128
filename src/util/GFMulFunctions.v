
//Takes One Cycle
module GFMulBy2(Clk, In, Out);
    input Clk;
    input [7:0] In;
    output reg [7:0] Out;

    always @(posedge Clk)
            Out <= ({In[7], In[7], In[7], In[7], In[7], In[7], In[7], In[7]} & 8'h1b) ^
                      {In[6:0] , 1'b0};
endmodule 

//Takes One Cycle
module GFMulBy3(Clk, In, Out);
    input Clk;
    input [7:0] In;
    output [7:0] Out;

    wire [7:0] MulBy2Out;
    
    GFMulBy2 tu(Clk, In, MulBy2Out);
    assign Out = In ^ MulBy2Out;
endmodule

//Takes One Cycles
module GFMulBy4(Clk, In, Out);
    input Clk;
    input [7:0] In;
    output [7:0] Out;

    wire [7:0] MulBy2Out;

    GFMulBy2 tu0(Clk, In, MulBy2Out);
    GFMulBy2 tu1(Clk, MulBy2Out, Out);
endmodule

//Takes 2 Cycles
module GFMulBy8(Clk, In, Out);
    input Clk;
    input [7:0] In;
    output [7:0] Out;

    wire [7:0] MulBy4Out;

    GFMulBy4 tu0(Clk, In, MulBy4Out);
    GFMulBy2 tu1(Clk, MulBy4Out, Out);
endmodule

// Takes 2 Cycles
module GFMulBy9(Clk, In, Out);
    input Clk;
    input [7:0] In;
    output [7:0] Out;
    
    wire [7:0] MulBy8Out;

    GFMulBy8 tu0(Clk, In, MulBy8Out);

    assign Out = MulBy8Out ^ In; 
endmodule 

// Takes 2 Cycles
module GFMulBy0xB(Clk, In, Out);
    input Clk;
    input [7:0] In;
    output [7:0] Out;

    wire [7:0] MulBy8Out, MulBy2Out;
    GFMulBy8 tu0(Clk, In, MulBy8Out);
    GFMulBy2 tu1(Clk, In, MulBy2Out);

    assign Out = MulBy8Out ^ MulBy2Out ^ In;
endmodule

// Takes 2 Cycles
module GFMulBy0xD(Clk, In, Out);
    input Clk;
    input [7:0] In;
    output [7:0] Out;

    wire [7:0] MulBy8Out, MulBy4Out;

    GFMulBy8 tu0(Clk, In, MulBy8Out);
    GFMulBy4 tu1(Clk, In, MulBy4Out);

    assign Out = MulBy8Out ^ MulBy4Out ^ In;
endmodule

// Takes 2 Cycles
module GFMulBy0xE(Clk, In, Out);
    input Clk;
    input [7:0] In;
    output [7:0] Out;

    wire [7:0] MulBy8Out, MulBy4Out, MulBy2Out;

    GFMulBy2 tu0(Clk, In, MulBy2Out);
    GFMulBy4 tu1(Clk, In, MulBy4Out);
    GFMulBy8 tu2(Clk, In, MulBy8Out);

    assign Out = MulBy2Out ^ MulBy4Out ^ MulBy8Out;

endmodule

