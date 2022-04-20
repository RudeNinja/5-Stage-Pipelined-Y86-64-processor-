module dec_tb;
  reg clk,CND;
  reg [3:0] iCode,rA,rB;
  reg [63:0] valE, valM;
  wire[63:0] memreg0,memreg1,memreg2,memreg3,memreg4,memreg5,memreg6,memreg7,memreg8,
             memreg9,memreg10,memreg11,memreg12,memreg13,memreg14,valA,valB;
             
             
  dec_wb dec_wb(
    .clk(clk),
    
    .iCode(iCode),
    .rA(rA),
    .rB(rB),
    .valA(valA),
    .valB(valB),
    .cnd(CND),
    .valE(valE),
    .valM(valM),
    .memreg0(memreg0),
    .memreg1(memreg1),
    .memreg2(memreg2),
    .memreg3(memreg3),
    .memreg4(memreg4),
    .memreg5(memreg5),
    .memreg6(memreg6),
    .memreg7(memreg7),
    .memreg8(memreg8),
    .memreg9(memreg9),
    .memreg10(memreg10),
    .memreg11(memreg11),
    .memreg12(memreg12),
    .memreg13(memreg13),
    .memreg14(memreg14)
  );
  
  initial begin 
    clk=0;
    

    #10 clk=~clk;
    #10 clk=~clk;iCode=4'b0110;rA=4'b0010;rB=4'b1011;valE=64'd0;valM=64'd0;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;iCode=4'b0101;
    #10 clk=~clk;
    
  end 
  
  initial 
		$monitor("clk=%d icode=%b  rA=%d rB=%d,valA=%d,valB=%d,valE=%d,valM=%d\n,memreg0=%d,memreg1=%d,memreg2=%d,memreg3=%d\n,memreg4=%d,memreg5=%d,memreg6=%d,memreg7=%d,memreg8=%d,memreg9=%d\n,memreg10=%d,memreg11=%d,memreg12=%d,memreg13=%d,memreg14=%d\n",clk,iCode,rA,rB,valA,valB,valE,valM,memreg0,memreg1,memreg2,memreg3,memreg4,memreg5,memreg6,memreg7,memreg8,
memreg9,memreg10,memreg11,memreg12,memreg13,memreg14);
endmodule
