module AddRoundKey(input_state, key, out);

input  [127:0] input_state;
input  [127:0] key;
output  [127:0] out;

assign out = input_state ^ key;

endmodule