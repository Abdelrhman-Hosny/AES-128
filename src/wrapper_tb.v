`include "wrapper.v"

module wrapper_tb();

reg clk = 0;
always begin
    #1 clk = ~clk;
end

reg enable, rst;
wire outLed128, outLed192, outLed256;

wrapper myWrapper(enable, rst, clk,
                    outLed128, outLed192, outLed256);
initial begin

enable = 0;
rst = 1; #10

rst = 0;  #20

enable = 1; #2 enable = 0; #1000

rst = 1;


#100


enable = 1; #2 enable = 0; #1000
$finish;
end

endmodule