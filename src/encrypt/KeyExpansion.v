`include "../SBytes.v"
module KeyExpansion(input [3:0] roundNumber, input [127:0] keyIn, input clk, output [127:0] keyOut [0:9]);


// random constant definition
localparam [31:0] rcon [0:9] ;
rcon[0]=32'h01_00_00_00;
rcon[1] = 32'h02_00_00_00;
rcon[2] = 32'h04_00_00_00;
rcon[3] = 32'h08_00_00_00;
rcon[4] = 32'h10_00_00_00;
rcon[5] = 32'h20_00_00_00;
rcon[6] = 32'h40_00_00_00;
rcon[7] = 32'h80_00_00_00;
rcon[8] = 32'h1b_00_00_00;
rcon[9] = 32'h36_00_00_00;

reg [31:0] words [0:43];
wire [31:0] temp[0:9];
genvar i, rNum, j;

// assign input key to words 0 -> 3
generate
    for (i = 0; i < 4; i = i + 1) begin
        words[i] = keyIn[i*32 + 31:i*32];
    end
endgenerate

// set the temp for each time j % 4 == 0 
generate
    for (rNum = 1; rNum < 11; rNum = rNum + 1) begin
        SBytes #(.NWords(1)) SBytes_block({words[rNum * 4][23:0],words[rNum * 4][31:24]}, temp[rNum - 1]);
    end
endgenerate

// generate the words
generate
    for (j = 4; j < 44; j = j + 1) begin
        words[j] = (j % 4 == 0) ? words[j - 4] ^ rcon[j/4 - 1] ^ temp[(j - 4)/4]: words[j - 4] ^ words[j - 1] ;
    
    end
endgenerate

// at each clock, output all keys
always @(posedge clk ) begin
    genvar k;
    generate
        for (k = 1; k < 11; k = k + 1) begin
            keyOut[k - 1] = { words[k*4 + 3], words[k*4 + 2], words[k*4 + 1], words[k*4 + 0] };
        end
    endgenerate
end


endmodule