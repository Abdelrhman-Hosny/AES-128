`include "../SBox.v"

module SBytes
 # (parameter NWords = 4)
 (input [NWords * 32 - 1:0] bytes_in, output [NWords * 32 - 1:0] bytes_out);

genvar  i;
generate
    for (i = 0; i < 4 * NWords; i = i + 1) begin
        SBox uut(bytes_in[i * 8 + 7:i * 8], bytes_out[i * 8 + 7:i * 8]);
    end
endgenerate
endmodule