`include "../InvSBox.v"

module InvSBytes(input [127:0] in, output [127:0] out);

genvar i;
generate
    for (i = 0; i < 16; i = i + 1) begin
        InvSBox uut(in[i * 8 + 7:i * 8], out[i * 8 + 7:i * 8]);
    end
endgenerate
endmodule