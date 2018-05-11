  8
`define wwB  8
`define wwS  4

module  multest;
   reg	[`wwA-1:0]	A, A1;
   reg [`wwB-1:0] 	B, B1;
   reg 			ck;
   reg 			start;
   reg [`wwS:0] 	st;
   wire [`wwA+`wwB:0] 	O;
   reg [`wwA+`wwB:0] 	OR;
   initial begin
      ck=0;
      start=0;
      st=0;
      $dumpvars;
      $dumpfile("mul.vcd");
      $monitor( "%t\tA=%h, B=%h, OUT=%h", $time, A1, B1, OR );
      A=1;
      B=1;
   end
   
   defparam MUL.wA=`wwA;
   defparam MUL.wB=`wwB;
   defparam MUL.wS=`wwS;
   
   
   mul	MUL(A , B , O ,  ck, start,fin);
   always	#10	ck = ~ck;
   always @(negedge ck) begin
      if( st == 0 ) begin
	 start <= 1;
      end
      else start <= 0;
      if( fin == 1 ) begin
	 A1<=A;
	 B1<=B;
	 OR <= O;
	 {B,A} <= {B,A} + 1;
	 st <= 0;
	 if( O != A*B ) begin
            $finish;
	 end
	 if( A == 0 && B == 0 ) begin
            $display( "OK\n" );
            $finish;
	 end
      end else  st <= st+1;
   end
endmodule
