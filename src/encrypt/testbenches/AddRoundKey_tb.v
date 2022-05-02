`include "../AddRoundKey.v"
module AddRoundKey_tb();

reg [127:0] state_in;
reg [127:0] key_in;
wire [127:0] state_out;
    
AddRoundKey dut(state_in, key_in, state_out);

initial begin
    $dumpfile("AddRoundKey.vcd");
    $dumpvars(0, AddRoundKey_tb);
 
state_in = 128'h3243f6a8885a308d313198a2e0370734;
key_in = 128'h2b7e151628aed2a6abf7158809cf4f3c;
#20
if (state_out == 128'h193de3bea0f4e22b9ac68d2ae9f84808) begin
    $display("Test Passed");
end else begin
    $display("Test Failed");
end
end


endmodule