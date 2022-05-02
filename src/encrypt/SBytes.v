`include "../SBox.v"

module SBytes(input [127:0] bytes_in, output [127:0] bytes_out);

genvar  i;
generate
    for (i = 0; i < 16; i = i + 1) begin
        SBox uut(bytes_in[i * 8 + 7:i * 8], bytes_out[i * 8 + 7:i * 8]);
    end
endgenerate
endmodule