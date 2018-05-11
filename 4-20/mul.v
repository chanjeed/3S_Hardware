module mul(A,B,O,ck,start,fin);
input[7:0]A,B;
input ck,start;
output[16:0]O;
output fin;
reg[7:0]AIN,BIN;
reg[16:0]C,O;
reg[3:0]st;
reg fin;
wire[16:0] OUT;
always @(posedge ck) begin
	if(start==1) begin
		AIN<=A;
		BIN<=B;
		C<=0;
		st<=0;
		fin<=0;
	end else begin
		case(st)
		0:C<=(C<<1)+AIN*BIN[7];
		1:C<=(C<<1)+AIN*BIN[6];
		2:C<=(C<<1)+AIN*BIN[5];
		3:C<=(C<<1)+AIN*BIN[4];
		4:C<=(C<<1)+AIN*BIN[3];
		5:C<=(C<<1)+AIN*BIN[2];
		6:C<=(C<<1)+AIN*BIN[1];
		7:begin C<=(C<<1)+AIN*BIN[0];fin<=1;end
		8:fin<=0;
		endcase
		st<=st+1;
	end 
end
always @(fin) begin
	O<=C;
end
endmodule
