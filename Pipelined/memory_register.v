module memory_register(
    clk,E_stat,E_icode,e_Cnd,e_valE,E_valP,E_valA,E_valB,E_rA,E_rB,E_valC,
    M_stat,M_icode,M_Cnd,M_valE,M_valA,M_rB,M_rA,M_valP,M_valC,M_valB);
    
    input clk;
    input [2:0] E_stat;
    input [3:0] E_icode;
    input  e_Cnd;
    input [63:0] e_valE,E_valP,E_valB,E_valC;
    input [63:0] E_valA;
    input [3:0] E_rA;
    input [3:0] E_rB;
    
    output reg [2:0] M_stat;
    output reg [3:0] M_icode;
    output reg  M_Cnd;
    output reg [63:0] M_valE;
    output reg [63:0] M_valA,M_valP,M_valC,M_valB;
    output reg [3:0] M_rA;
    output reg [3:0] M_rB;

    always @(posedge clk)
        begin
            M_stat<=E_stat;
            M_icode<=E_icode;
            M_Cnd<=e_Cnd;
            M_valE<=e_valE;
            M_valA<=E_valA;
            M_rB<=E_rB;
            M_rA<=E_rA;    
            M_valB<=E_valB;
            M_valC<=E_valC;
            M_valP<=E_valP;                  
        end
endmodule        






    
