
  `timescale 1ns / 1ps
module fetch_test;
  reg clk;
  reg [63:0] PC;
  
  wire [3:0] icode;
  wire [3:0] ifun;
  wire [3:0] rA;
  wire [3:0] rB; 
  wire [63:0] valC;
  wire [63:0] valP;
  wire HF;
  wire instr_Validity;
  wire imem_error;

  fetch fetch(
    .clk(clk),
    .PC(PC),
    .rA(rA),
    .rB(rB),
    .iCode(icode),
    .iFun(ifun),
    
    .valC(valC),
    .valP(valP),
    .instr_Validity(instr_Validity), 
    .imem_error(imem_error),
    .HF(HF)
  );
  
  initial begin 
    clk=0;
    PC=64'd0;

    #10 clk=~clk;PC=64'd10;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
     #10 clk=~clk;PC=valP;
    #10 clk=~clk;
     #10 clk=~clk;PC=valP;
    #10 clk=~clk;
     #10 clk=~clk;PC=valP;
    #10 clk=~clk;
     #10 clk=~clk;PC=valP;
    #10 clk=~clk;
     #10 clk=~clk;PC=valP;
    #10 clk=~clk;
     #10 clk=~clk;PC=valP;
    #10 clk=~clk;
     #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    
  end 
  
  initial 
		$monitor("clk=%d PC=%d icode=%b ifun=%b rA=%d rB=%d,valC=%d,valP=%d,HF=%d,imem_error=%d,instr_Validity=%d\n",clk,PC,icode,ifun,rA,rB,valC,valP,HF,imem_error,instr_Validity);
endmodule
