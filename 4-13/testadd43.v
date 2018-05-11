module testadd4;
  wire		[4:0] s;
  reg		[3:0] a, b;
  reg		ck;
  initial begin
	$monitor("%t %b + %b = %b" , $time, a, b, s);
	a <= 0;   b <= 0;
	ck <= 0;
  end
  always  #10 ck <= ~ck;
  always @(negedge ck) begin
	if(s!=a+b) begin
	$finish
	end
	if(a=='hf&&b=='hf) begin
	$display("OK\n");
	$finish
	end
  end
  always @(posedge ck) begin
 	{b;a}={b;a}+1;
  end
  add4 add ( s,a,b );
endmodule
