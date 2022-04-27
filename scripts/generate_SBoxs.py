from copy import deepcopy

subbyte_dict = {}
hexa_dict = {
    0: '0', 1: '1', 2: '2', 3: '3',
    4: '4', 5: '5', 6: '6', 7: '7',
    8: '8', 9: '9', 10: 'A', 11: 'B',
    12: 'C', 13: 'D', 14: 'E', 15: 'F',
}

with open('./misc/SBox.txt', 'r') as f:
    for i, line in enumerate(f.readlines()):
        for j, byte in enumerate(line.split()):
            local_key = hexa_dict[i] + hexa_dict[j]
            subbyte_dict[local_key] = byte

file_lines = []
file_lines.append("module SBox(input [7:0] input_byte, output reg[7:0] output_byte);\n")
file_lines.append("always @(input_byte) begin\n")
file_lines.append("case(input_byte)\n")

inv_file_lines = deepcopy(file_lines)

for k, v in subbyte_dict.items():
    file_lines.append(f"8'h{k}: output_byte = 8'h{v};\n")
    inv_file_lines.append(f"8'h{v}: output_byte = 8'h{k};\n")

file_lines.append("endcase\nend\nendmodule")
inv_file_lines.append("endcase\nend\nendmodule")

with open('./src/encrypt/SBox.v', 'w') as f:
    f.writelines(file_lines)

with open('./src/decrypt/InvSBox.v', 'w') as f:
    f.writelines(inv_file_lines)
