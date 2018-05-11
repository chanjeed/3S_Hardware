module mul(A,B,O,ck,start,fin);
   parameter wA=16;
   parameter wB=16;
   parameter wS=5;
   
   input [wA-1:0] A;
   input [wB-1:0] B;
   input 	  ck,start;
   output [wA+wB:0] O;
   output 	    fin;
   
   reg [wS-1:0]     st;
   reg [wA:0] 	    AIN;
   reg [wB:0] 	    BIN;
   reg [wA+wB:0]    O,O1;
   reg 		    fin;
   
always @(posedge ck) begin
	if( start == 1 ) begin
	   st <= wB-1;
	   fin <= 0;
	   AIN <= A;
	   BIN <= B;
	   O1 <= 0;
	end else begin
	   if( st==0 ) begin
	      if( BIN[st] == 1 ) O <= (O1<<1) + AIN;
	      else O <= (O1<<1);
	      fin<= 1;
	   end else begin
	      if( BIN[st] == 1 ) O1 <= (O1<<1) + AIN;
	      else O1 <= (O1<<1);
	   end
	   if( fin == 1 ) fin <= 0;
	   st <= st - 1;
	end
end

endmodule
