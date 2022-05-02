module KeyExpansion(input [3:0] roundNumber);

reg [31:0] rcon;

always @(roundNumber) begin
case(roundNumber)

4'h0: rcon=32'h01_00_00_00;
4'h1: rcon=32'h02_00_00_00;
4'h2: rcon=32'h04_00_00_00;
4'h3: rcon=32'h08_00_00_00;
4'h4: rcon=32'h10_00_00_00;
4'h5: rcon=32'h20_00_00_00;
4'h6: rcon=32'h40_00_00_00;
4'h7: rcon=32'h80_00_00_00;
4'h8: rcon=32'h1b_00_00_00;
4'h9: rcon=32'h36_00_00_00;
default: rcon=32'h00_00_00_00;

endcase
end



endmodule