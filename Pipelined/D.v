module D(clk ,f_iCode, f_iFun, f_stat, f_rA, f_rB , f_valC, f_valP, D_iCode , D_iFun , D_stat , D_rA , D_rB , D_valC , D_valP);
input clk;
input[3:0] f_iCode,f_iFun,f_rA,f_rB;
input[2:0] f_stat;
input[63:0] f_valC,f_valP;

output reg[3:0] D_iCode,D_iFun,D_rA,D_rB;
output reg[2:0] D_stat;
output reg[63:0] D_valC,D_valP;

always @(posedge clk ) begin
    D_iCode <= f_iCode;
    D_iFun <= f_iFun;
    D_stat <= f_stat;
    D_rA <= f_rA;
    D_rB <= f_rB;
    D_valC <= f_valC;
    D_valP <= f_valP; 

end

endmodule
