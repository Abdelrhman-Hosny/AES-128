subbyte_dict = {}
hexa_dict = {
    0: '0', 1: '1', 2: '2', 3: '3',
    4: '4', 5: '5', 6: '6', 7: '7',
    8: '8', 9: '9', 10: 'A', 11: 'B',
    12: 'C', 13: 'D', 14: 'E', 15: 'F',
}

with open('./SBox.txt', 'r') as f:
    for i, line in enumerate(f.readlines()):
        for j, byte in enumerate(line.split()):
            local_key = hexa_dict[i] + hexa_dict[j]
            subbyte_dict[local_key] = byte

file_lines = []
file_lines.append("case(input_byte)\n")


for k, v in subbyte_dict.items():
    file_lines.append(f"8'h{k}: output_byte = 8'h{v};\n")

file_lines.append("endcase\n")

with open('./src/SBox.v', 'w') as f:
    f.writelines(file_lines)
