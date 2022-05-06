`include "../SBytes.v"
module SBytes_tb();

reg [127:0] state_in;
wire [127:0] state_out;
    
SBytes #(.NWords(4)) dut (state_in, state_out);

initial begin
    $dumpfile("SBytes.vcd");
    $dumpvars(0, SBytes_tb);
 
state_in = 128'h193de3bea0f4e22b9ac68d2ae9f84808;
#20
if (state_out == 128'hd42711aee0bf98f1b8b45de51e415230) begin
    $display("Test Passed");
end else begin
    $display("Test Failed");
end
end


endmodule