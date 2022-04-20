module fetch_decode_tb;
  reg clk;
  reg [63:0] PC;
  reg [63:0] memreg[0:14];

  wire [3:0] iCode;
  wire [3:0] iFun;
  wire [3:0] rA;
  wire [3:0] rB; 
  wire [63:0] valC;
  wire [63:0] valP;
  wire [63:0] valA;
   wire [63:0] valB;
  integer i,j;

   
    
  initial begin
  memreg[0] = 64'd0;

    
    
       for(i=1;i<15;i = i+1)
    begin
      memreg[i] = memreg[i-1] + 1;
    end
  end
  
  

  fetch fetch(
    .clk(clk),
    .PC(PC),
    
    .rA(rA),
    .rB(rB),
    
    .iCode(iCode),
    .iFun(iFun),
    .valC(valC),
    .valP(valP)
  );

  decode decode(
    .clk(clk),
    .iCode(iCode),
    .rA(rA),
    .rB(rB),
    .reg_stackA(memreg[rA]),
    .reg_stackB(memreg[rB]),
    .reg_stack4(memreg[4]),

    
    .valA(valA),
    .valB(valB)
  );

  initial 
  begin
  
   clk = 1;
  
     

    #10 clk=~clk;PC=64'd64;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
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
    #10 clk=~clk;
  end 
  
  initial
   $monitor("clk=%d icode=%b ifun=%b rA=%d rB=%d valA=%d valB=%d P=%d\n ",clk,iCode,iFun,rA,rB,valA,valB,valP);


endmodule
