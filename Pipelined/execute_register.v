module execute_register(
                        clk,D_stat,D_icode,D_ifun,D_valP,D_valC,d_valA,d_valB,d_rA,d_rB,
                        E_stat,E_icode,E_ifun,E_valC,E_valA,E_valB,E_rA,E_rB,E_valP
                        );
        input clk;
        input [2:0] D_stat;
        input [3:0]  D_icode;
        input [3:0] D_ifun;
        input [63:0] D_valC,D_valP;
        input [63:0] d_valA;
        input [63:0] d_valB;
        input [3:0] d_rA;
        input [3:0] d_rB;

        output reg[2:0] E_stat;
        output reg[3:0]  E_icode;
        output reg[3:0] E_ifun;
        output reg[63:0] E_valC,E_valP;
        output reg[63:0] E_valA;
        output reg[63:0] E_valB;
        output reg[3:0] E_rA;
        output reg[3:0] E_rB;

        always @(posedge clk)
            begin
                E_stat<=D_stat;
                E_icode<=D_icode;
                E_ifun<=D_ifun;
                E_valC<=D_valC;
                E_valA<=d_valA;
                E_valB<=d_valB;
                E_rB<=d_rB;
                E_rA<=d_rA;
                E_valP<=D_valP;
            end
endmodule            


        
        
