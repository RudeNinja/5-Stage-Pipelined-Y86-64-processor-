module bubble(E_iCode,D_iCode,M_iCode,d_rA,d_rB,e_Cnd,E_destM,D_bubble,E_bubble);

input[3:0] E_iCode,E_destM,D_iCode,M_iCode,d_rA,d_rB;
input e_Cnd;

output reg D_bubble, E_bubble;

initial begin
    D_bubble  = 1'b0;
    E_bubble = 1'b0;

end

always@(*)
begin
if (((E_iCode==4'b0111)&(e_Cnd==1'b0))||((D_iCode==4'b1001)||(E_iCode==4'b1001)||(M_iCode==4'b1001))) 
begin
    D_bubble = 1'b1;
end

if(((E_iCode==4'b0111)&(e_Cnd==1'b0)) ||(((E_iCode==4'b0101)||(E_iCode==4'b1011))&((E_destM==d_rA)||(E_destM==d_rB))))
begin
    E_bubble = 1'b1;
end
end

endmodule