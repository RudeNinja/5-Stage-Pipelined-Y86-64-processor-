module W(clk,m_stat,M_iCode,M_rA,M_rB,M_valC,M_valP,M_valA,M_valB,M_Cnd,W_Cnd,M_valE,m_valM,W_stat,W_iCode,W_valE,W_valM,W_rB,W_rA,W_valC,W_valA,W_valB,W_valP);
input clk,M_Cnd;
input[2:0] m_stat;
input [3:0] M_iCode,M_rA,M_rB;
input [63:0] M_valE,m_valM,M_valC,M_valP,M_valA,M_valB;

output reg[2:0] W_stat;
output reg[3:0] W_iCode,W_rA,W_rB;
output reg[63:0] W_valE,W_valM,W_valA,W_valB,W_valC,W_valP;
output reg W_Cnd;

always @(posedge clk ) begin
    W_stat <= m_stat;
    W_iCode <= M_iCode;
    W_valE<=M_valE;
    W_valM <= m_valM;
    W_valC<=M_valC;
    W_valP<=M_valP;
    W_Cnd<=M_Cnd;
    W_valA<=M_valA;
    W_valB<=M_valB;
    W_rB <= M_rB;
    W_rA <= M_rA;

end


endmodule


