`timescale 1ns / 1ps

`include "D.v"
`include "execute_register.v"
`include "F.v"
`include "memory_register.v"
`include "W.v"
`include "fetch.v"
`include "execute_new.v"
`include "dec_wb.v"
`include "memory.v"
`include "pc_update.v"

module proc;
  reg clk;
  
  reg [63:0] PC;

  reg stat[0:2]; // |AOK|INS|HLT|
  
  wire [63:0] updated_pc;
  wire [63:0] f_pred_pc;

  wire [2:0]  f_stat,cc;
  wire [3:0]  f_icode;
  wire [3:0]  f_ifun; 
  wire [3:0]  f_rA;
  wire [3:0]  f_rB,e_dstE;
  wire [63:0] f_valC;
  wire [63:0] f_valP;
  wire        imem_error;
  wire        hltins;
  wire        instr_valid;
  
  wire [2:0]  d_stat;
  wire [3:0]  d_icode;
  wire [3:0]  d_ifun;
  wire [3:0]  d_rA;
  wire [3:0]  d_rB;
  wire [63:0] d_valC;
  wire [63:0] d_valP;
  wire [63:0] d_valA;
  wire [63:0] d_valB;

  wire [2:0]  e_stat;
  wire [3:0]  e_icode;
  wire [3:0]  e_ifun;
  wire        e_cnd;
  wire [3:0]  e_rA;
  wire [3:0]  e_rB;
  wire [63:0] e_valC;
  wire [63:0] e_valP;
  wire [63:0] e_valA;
  wire [63:0] e_valB;
  wire [63:0] e_valE;


  wire [2:0]  m_stat;
  wire [3:0]  m_icode;
  wire        m_cnd;
  wire [3:0]  m_rA;
  wire [3:0]  m_rB;
  wire [63:0] m_valC;
  wire [63:0] m_valP;
  wire [63:0] m_valA;
  wire [63:0] m_valB;
  wire [63:0] m_valE;
  wire [63:0] m_valM;
  
  wire [2:0]  w_stat ;
  wire [3:0]  w_icode;
  wire        w_cnd;
  wire [3:0]  w_rA;
  wire [3:0]  w_rB;
  wire [63:0] w_valC;
  wire [63:0] w_valP;
  wire [63:0] w_valA;
  wire [63:0] w_valB;
  wire [63:0] w_valE;
  wire [63:0] w_valM;

  wire [63:0] memreg0,memreg1,memreg2,memreg3,memreg4,memreg5,memreg6,memreg7,memreg8,
                 memreg9,memreg10,memreg11,memreg12,memreg13,memreg14;

  F freg(
    .clk(clk),
    .pred_PC(f_valP),
    .F_predPC(f_pred_pc)
  );  

  D dreg(
    
    .clk(clk),

    .f_stat   (f_stat),
    .f_iCode  (f_icode),
    .f_iFun   (f_ifun),
    .f_rA     (f_rA),
    .f_rB     (f_rB),
    .f_valC   (f_valC),
    .f_valP   (f_valP),

    .D_stat   (d_stat),
    .D_iCode  (d_icode),
    .D_iFun   (d_ifun),
    .D_rA     (d_rA),
    .D_rB     (d_rB),
    .D_valC   (d_valC),
    .D_valP   (d_valP)

  );

  execute_register ereg( 

    .clk(clk),

    .D_stat  (d_stat),
    .D_icode (d_icode),
    .D_ifun  (d_ifun),
    .d_rA    (d_rA),
    .d_rB    (d_rB),
    .D_valC  (d_valC),
    .D_valP  (d_valP),
    .d_valA  (d_valA),
    .d_valB  (d_valB),
    
    .E_stat  (e_stat),
    .E_icode (e_icode),
    .E_ifun  (e_ifun),
    .E_rA    (e_rA),
    .E_rB    (e_rB),
    .E_valC  (e_valC),
    .E_valP  (e_valP),
    .E_valA  (e_valA),
    .E_valB  (e_valB)

  );

  memory_register mreg(

    .clk(clk),
    
    .E_stat  (e_stat),
    .E_icode (e_icode),
    .E_rA    (e_rA),
    .E_rB    (e_rB),
    .E_valC  (e_valC),
    .E_valP  (e_valP),
    .E_valA  (e_valA),
    .E_valB  (e_valB),
    .e_Cnd   (e_cnd),
    .e_valE  (e_valE),

    .M_stat  (m_stat),
    .M_icode (m_icode),
    .M_rA    (m_rA),
    .M_rB    (m_rB),
    .M_valC  (m_valC),
    .M_valP  (m_valP),
    .M_valA  (m_valA),
    .M_valB  (m_valB),
    .M_Cnd   (m_cnd),
    .M_valE  (m_valE)

  );

  W wreg(

    .clk(clk),

    .m_stat  (m_stat),
    .M_iCode (m_icode),
    .M_rA    (m_rA),
    .M_rB    (m_rB),
    .M_valC  (m_valC),
    .M_valP  (m_valP),
    .M_valA  (m_valA),
    .M_valB  (m_valB),
    .M_Cnd   (m_cnd),
    .M_valE  (m_valE),
    .m_valM  (m_valM),

    .W_stat  (w_stat),
    .W_iCode (w_icode),
    .W_rA    (w_rA),
    .W_rB    (w_rB),
    .W_valC  (w_valC),
    .W_valP  (w_valP),
    .W_valA  (w_valA),
    .W_valB  (w_valB),
    .W_Cnd   (w_cnd),
    .W_valE  (w_valE),
    .W_valM  (w_valM)
  );

  pc_update pcup(
    .clk(clk),
    
    .icode(w_icode),
    .cnd(w_cnd),
    .valC(w_valC),
    .valM(w_valM),
    .valP(f_pred_pc),
    .PC_updated(updated_pc)
  ); 

  fetch fetch(          // fetch
    .clk(clk),
    .PC(PC),
    .rA(f_rA),
    .rB(f_rB),
    .iCode(f_icode),
    .iFun(f_ifun),
    
    .valC(f_valC),
    .valP(f_valP),
    .instr_Validity(instr_Validity),
    .imem_error(imem_error),
    .HF(hltins)
  );

  execute execute(
    .clk(clk),
    .icode(e_icode),
    .ifun(e_ifun),
    .valA(e_valA),
    .valB(e_valB),
    .valC(e_valC),
    .valE(e_valE),
    .cc(cc),
    .cnd(e_cnd),
    .e_dstE(e_dstE)
  );

  dec_wb decode_wb(
    
    .clk(clk),

    .D_iCode(d_icode),
    .D_rA(d_rA),
    .D_rB(d_rB),
    .D_Cnd(d_cnd),
    .D_valA(d_valA),
    .D_valB(d_valB),
    
    .W_iCode(w_icode),
    .W_rA(w_rA),
    .W_rB(w_rB),
    .W_Cnd(w_cnd),
    .W_valE(w_valE),
    .W_valM(w_valM),
    
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
    .icode(m_icode),
    .valA(m_valA),
    
    .valE(m_valE),
    .valP(m_valP),
    .valM(m_valM),
    .data_memory_error(datamem)
  );

 

  initial begin
    $dumpfile("proc.vcd");
    $dumpvars(0,proc);
    stat[0]=1;
    stat[1]=0;
    stat[2]=0;
    clk=0;
    PC=64'd20;
  end 
  initial begin
   #5 clk=~clk;
    #5 clk=~clk;
     #5 clk=~clk;
      #5 clk=~clk;
       #5 clk=~clk;
        #5 clk=~clk;
         #5 clk=~clk;
         #5 clk=~clk;
         #5 clk=~clk;
          end
                           

  always@(*)
  begin
    PC=updated_pc;
  end

  always@(*)
  begin
    if(hltins)
    begin
      stat[2]=hltins;
      stat[1]=1'b0;
      stat[0]=1'b0;
    end
    else if(instr_valid==1'b0)
    begin
      stat[1]=instr_valid;
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
    if(stat[2]==1'b1)
    begin
      $finish;
    end
  end

  initial 
    $monitor("clk=%d PC=%d f_stat=%d cc=%d f_icode=%d f_ifun=%d f_rA=%d f_rB=%d e_dstE=%d f_valC=%d f_valP=%d imem_error=%d hltins=%d instr_valid=%d d_stat=%d d_icode=%d d_ifun=%d d_rA=%d d_rB=%d d_valC=%d d_valP=%d d_valA=%d d_valB=%d e_stat=%d e_icode=%d e_ifun=%d e_cnd=%d e_rA=%d e_rB=%d e_valC=%d e_valP=%d e_valA=%d e_valB=%d e_valE=%d m_stat=%d m_icode=%d m_cnd=%d m_rA=%d m_rB=%d m_valC=%d m_valP=%d m_valA=%d m_valB=%d m_valE=%d m_valM=%d w_stat=%d w_icode=%d w_cnd=%d w_rA=5d w_rB=%d w_valC=%d w_valP=%d w_valA=%D w_valB=%d w_valE=%d w_valM=%d",clk,PC,f_stat,cc,f_icode,f_ifun,f_rA,f_rB,e_dstE,f_valC,f_valP,imem_error,hltins,instr_valid,d_stat,d_icode,d_ifun,d_rA,d_rB,d_valC,d_valP,d_valA,d_valB,e_stat,e_icode,e_ifun,e_cnd,e_rA,e_rB,e_valC,e_valP,e_valA,e_valB,e_valE ,m_stat,m_icode,m_cnd,m_rA,m_rB,m_valC,m_valP,m_valA,m_valB,m_valE,m_valM, w_stat,w_icode,w_cnd,w_rA,w_rB,w_valC,w_valP,w_valA,w_valB,w_valE,w_valM);
	//$monitor("clk=%d f=%d d=%d e=%d m=%d wb=%d",clk,f_icode,d_icode,e_icode,m_icode,w_icode);
		
endmodule 
