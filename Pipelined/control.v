module stall(E_iCode,M_iCode,D_iCode,E_destM,d_rA,d_rB,F_stall,D_stall);


input [3:0]E_iCode,M_iCode,D_iCode,E_destM,d_rA,d_rB;
output reg F_stall,D_stall;


initial begin
    F_stall = 1'b0;
    D_stall = 1'b0;
end

always@(*) 
    
begin

if(((E_iCode== 4'b0101) || (E_iCode==4'b1011))&((E_destM==d_rA)||(E_destM==d_rB)))
begin
F_stall = 1'b1;
D_stall = 1'b1;
end


else if((D_iCode==4'b1001)||(M_iCode==4'b1001)||(E_iCode==4'b1001))
begin
    F_stall = 1'b1;
end
end

endmodule








