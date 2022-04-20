`timescale 1ns / 1ps

`include "fetch.v"
`include "execute_new.v"
`include "dec_wb.v"
`include "memory.v"
`include "pc_update.v"

module processor_seq;
  reg clk;
  
  reg [63:0] PC;

  reg stat[0:2]; // for AOK INS HLT

  wire [3:0] iCode;
  wire [3:0] iFun;
  wire [3:0] rA;
  wire [3:0] rB; 
  wire [63:0] valC;
  wire [63:0] valP;
  wire instr_Validity;
  wire imem_error;
  wire [63:0] valA;
  wire [63:0] valB;
  wire [63:0] valE;
  wire [63:0] valM;
  wire cnd;
  wire halt_flag;
  wire [63:0] PC_updated;

  wire[63:0] memreg0,memreg1,memreg2,memreg3,memreg4,memreg5,memreg6,memreg7,memreg8,
             memreg9,memreg10,memreg11,memreg12,memreg13,memreg14;   // register file
  wire data_memory_error;

  
  wire[2:0] cc;  // for zf, sf and of 
  integer i;

  fetch fetch(          // fetch
    .clk(clk),
    .PC(PC),
    .rA(rA),
    .rB(rB),
    .iCode(iCode),
    .iFun(iFun),
    
    .valC(valC),
    .valP(valP),
    .instr_Validity(instr_Validity),
    .imem_error(imem_error),
    .HF(halt_flag)
  );

  execute execute(      // execute
    .clk(clk),
    .icode(iCode),
    .ifun(iFun),
    .valA(valA),
    .valB(valB),
    .valC(valC),
    .cnd(cnd),
    .valE(valE),
    
    .cc(cc)
    
  );

  dec_wb dec_wb(       // decode write back
    .clk(clk),
    
    .iCode(iCode),
    .rA(rA),
    .rB(rB),
    .valA(valA),
    .valB(valB),
    .cnd(cnd),
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

  memory mem(           // memory
    .clk(clk),
    .icode(iCode),
    .valA(valA),
    
    .valE(valE),
    .valP(valP),
    .valM(valM),
    .data_memory_error(data_memory_error)
  );

  pc_update pc_update(  // pc_Update
    .clk(clk),
    
    .icode(iCode),
    .cnd(cnd),
    .valC(valC),
    .valM(valM),
    .valP(valP),
    
    .PC_updated(PC_updated)
    
  ); 

  

  initial begin
    $dumpfile("processor_seq.vcd");
    $dumpvars(0,processor_seq);
    stat[0]=1;
    stat[1]=0;
    stat[2]=0;
    clk=0;
    
  end 
  
  initial begin
  #5 clk = ~clk;PC=64'd10;
  #5 clk = ~clk;
  #5 clk = ~clk;
  #5 clk = ~clk;
  #5 clk = ~clk;
  #5 clk = ~clk;
  #5 clk = ~clk;
  
  #5 clk = ~clk;
  #5 clk = ~clk;
  #5 clk = ~clk;
  #5 clk = ~clk;
  #5 clk = ~clk;
  #5 clk = ~clk;
  #5 clk = ~clk;
  #5 clk = ~clk;
  #5 clk = ~clk;
  end
    
  always@(*)
  begin
    PC=PC_updated;
    if(halt_flag)  // if halt is encountered
    begin
      stat[2]=halt_flag;
      stat[1]=1'b0;
      stat[0]=1'b0;
    end
    else if(instr_Validity)
    begin
      stat[1]=instr_Validity;
      stat[2]=1'b0;
      stat[0]=1'b0;
    end
    else
    begin
      stat[0]=1'b1;
      stat[1]=1'b0;
      stat[2]=1'b0;
    end
  end

  

  
  always@(*)
  begin
    if(stat[2]==1'b1)  // if HALT is true
    begin
      $finish;
    end
  end

  initial 
    
		$monitor("clk=%d icode=%b ifun=%b rA=%b rB=%b valA=%d valB=%d valC=%d valE=%d valM=%d insval=%d memerr=%d cnd=%d halt=%d 0=%d 1=%d 2=%d 3=%d 4=%d 5=%d 6=%d 7=%d 8=%d 9=%d 10=%d 11=%d 12=%d 13=%d 14=%d data_memory_error=%d valP = %d updated_PC=%d\n",clk,iCode,iFun,rA,rB,valA,valB,valC,valE,valM,instr_Validity,imem_error,cnd,stat[2],memreg0,memreg1,memreg2,memreg3,memreg4,memreg5,memreg6,memreg7,memreg8,
             memreg9,memreg10,memreg11,memreg12,memreg13,memreg14,data_memory_error,valP,PC_updated);
		
endmodule
