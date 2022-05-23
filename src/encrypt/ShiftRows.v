module ShiftRows (
  input  [127:0] dataIn,
    output [127:0] dataOut
	);
	


//Shift Rows

//first column
assign dataOut[127:120] = dataIn[127:120];
assign dataOut[119:112] = dataIn[87:80];
assign dataOut[111:104] = dataIn[47:40];
assign dataOut[103:96] = dataIn[7:0];

//second column

assign 	dataOut[95:88] = dataIn[95:88];
assign  dataOut[87:80] = dataIn[55:48];
assign  dataOut[79:72] = dataIn[15:8];
assign  dataOut[71:64] = dataIn[103:96];

//third column
assign dataOut[63:56] = dataIn[63:56];
assign dataOut[55:48] = dataIn[23:16];
assign dataOut[47:40] = dataIn[111:104];
assign dataOut[39:32] = dataIn[71:64];

	//forth column 
assign dataOut[31:24] = dataIn[31:24];
assign dataOut[23:16] = dataIn[119:112];
assign dataOut[15:8] = dataIn[79:72];
assign dataOut[7:0] = dataIn[39:32];


    
endmodule