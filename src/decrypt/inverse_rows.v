module inverse_rows (
  //input wire clk,
  //input wire reset,    
  input  wire  [0:127] Data_in,
    output wire [127:0] Data_out,
	output reg done );
	
   reg [127:0] temp;  
	reg [127:0] Data_reg;
	
	
	always @*
    begin
    	
    	 Data_reg = Data_in;
	   
		 //Inverse Shift Rows
		 
		 //first column
	    temp[127:120] = Data_reg[127:120];
	    temp[87:80] = Data_reg[119:112];
	    temp[43:40] = Data_reg[111:104];
	    temp[7:0] = Data_reg[103:96];
	 
	    //second column
	    temp[95:88] = Data_reg[95:88];
	    temp[55:48] = Data_reg[87:80];
	    temp[15:8] = Data_reg[79:72];
	    temp[103:96] = Data_reg[71:64];
	
	    //third column
	    temp[63:56] = Data_reg[63:56];
	    temp[23:16] = Data_reg[55:48];
	    temp[111:104] = Data_reg[47:40];
	    temp[71:64] = Data_reg[39:32];
	    
		 //forth column 
	    temp[31:24] = Data_reg[31:24];
	    temp[119:112] = Data_reg[23:16];
	    temp[79:72] = Data_reg[15:8];
	    temp[39:32] = Data_reg[7:0];
	    
	    Data_reg[127:0] = temp[127:0];
    end
    
    assign Data_out = Data_reg;
    
endmodule