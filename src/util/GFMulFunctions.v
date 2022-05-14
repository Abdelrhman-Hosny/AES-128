module GFMulBy2(Clk, In, Out);
    input Clk;
    input [7:0] In;
    output reg [7:0] Out;

    always @(posedge Clk)
            Out <= ({In[7], In[7], In[7], In[7], In[7], In[7], In[7], In[7]} & 8'h1b) ^
                      {In[6:0] , 1'b0};
endmodule 

