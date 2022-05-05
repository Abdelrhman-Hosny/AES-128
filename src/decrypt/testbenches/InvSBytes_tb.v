`include "../InvSBytes.v"

module InvSBytes_tb();

reg [127:0] state_in;
wire [127:0] state_out;

InvSBytes dut(state_in, state_out);

initial begin
    $dumpfile("InvSBytes.vcd");
    $dumpvars(0, InvSBytes_tb);
 
state_in = 128'hd42711aee0bf98f1b8b45de51e415230;
#20
if (state_out == 128'h193de3bea0f4e22b9ac68d2ae9f84808) begin
    $display("Test Passed");
end else begin
    $display("Test Failed");
end

end

endmodule