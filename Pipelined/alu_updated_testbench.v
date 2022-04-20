module ALU_test;
  reg [3:0] icode;
  reg [1:0]control;
  reg signed [63:0]a;
  reg signed [63:0]b;

  wire signed [63:0]ans;
  wire overflow;
  wire zf;
  wire sf;

  ALU_final uut(
    .icode(icode),
    .x(a),
    .y(b),
    .control(control),
    .result(ans),
    .zf(zf),
    .sf(sf),
    .OF(overflow)
  );

  initial begin
    $dumpfile("Alu_test.vcd");
    $dumpvars(0,ALU_test);
    icode=4'b0000;
    control=2'b00;
		a = -64'd90;
		b = 64'd4;
    #20 control=2'b01;a=64'hABCDABCDABCDABCA;b=64'hABCDABCDABCDACBD;
    #20 control=2'b10;a=64'h1011;b=64'b0100;
    $display($time,"control=%b icode=%b a=%b b=%b ans=%b zf=%b sf=%b overflow=%b",control,icode,a,b,ans,zf,sf,overflow);
    #20 icode=4'b0110;control=2'b01;a=64'b1011;b=64'b1011;
    $display($time,"control=%b a=%b b=%b ans=%b zf=%b sf=%b overflow=%b",control,a,b,ans,zf,sf,overflow); 
    #20 icode=4'b0010;control=2'b00;a=-64'd40;b=-64'd50;
    #20 icode=4'b0110;control=2'b01;a=64'd30;b=-64'd80;
    
	end
	
  initial 
		$monitor($time,"control=%b icode=%d a=%d b=%d ans=%d zf=%b sf=%b overflow=%d",control,icode,a,b,ans,zf,sf,overflow);
endmodule