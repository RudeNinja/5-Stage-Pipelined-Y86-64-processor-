module dec_wb(clk,W_iCode,D_iCode,D_rA,D_rB,W_rA,W_rB,D_valA,D_valB,D_Cnd,W_Cnd,W_valE,W_valM,memreg0,memreg1,memreg2,memreg3,memreg4,memreg5,memreg6,
             memreg7,memreg8, memreg9,memreg10,memreg11,memreg12,memreg13,memreg14);

input clk,W_Cnd,D_Cnd;
input[3:0] D_iCode,D_rA,D_rB,W_iCode,W_rA,W_rB;
input[63:0] W_valE,W_valM;
output reg[63:0] D_valA,D_valB;

output reg[63:0] memreg0,memreg1,memreg2,memreg3,memreg4,memreg5,memreg6,memreg7,memreg8,
                 memreg9,memreg10,memreg11,memreg12,memreg13,memreg14;
                 
reg[63:0] memreg[0:14];

integer i;

initial begin
memreg[0] = 64'd0;

for(i=1;i<15;i=i+1)
begin
memreg[i] = memreg[i-1]+64'd1;
end
end


// Decode stage
always@(*)
begin
if(D_iCode==4'b0010)
begin
D_valA = memreg[D_rA];
end

else if(D_iCode==4'b0100) //rmmovq
begin
D_valA<=memreg[D_rA];
D_valB<=memreg[D_rB];
end
   
else if(D_iCode==4'b0101) //mrmovq
begin
D_valB<=memreg[D_rB];
end

else if(D_iCode==4'b0110) //OPq
begin
D_valA<=memreg[D_rA];
D_valB<=memreg[D_rB];
end
    
else if(D_iCode==4'b1000) //call
begin
D_valB<=memreg[4]; //rsp
end

else if((D_iCode==4'b1001) || (D_iCode==4'b1011) ) //ret or popq
begin
D_valA<=memreg[4]; //rsp
D_valB<=memreg[4]; //rsp
end
   
else if(D_iCode==4'b1010) //pushq
begin
D_valA<=memreg[D_rA];
D_valB<=memreg[4]; //rsp
end
    


memreg0 <= memreg[0];
memreg1 <= memreg[1];
memreg2 <= memreg[2];
memreg3 <= memreg[3];
memreg4 <= memreg[4];
memreg5 <= memreg[5];
memreg6 <= memreg[6];
memreg7 <= memreg[7];
memreg8 <= memreg[8];
memreg9 <= memreg[9];
memreg10 <= memreg[10];
memreg11 <= memreg[11];
memreg12 <= memreg[12];
memreg13 <= memreg[13];
memreg14 <= memreg[14];

end

// Write back
always @(*) 
begin
if((W_iCode == 4'b0010) & (W_Cnd==1'b1))
begin
memreg[W_rB] <= W_valE;  
end


else if((W_iCode == 4'b0011) ||(W_iCode==4'b0110)) // for  irmovq and OPq
begin  
memreg[W_rB] <= W_valE;
end

else if (W_iCode ==4'b0101)  // for mrmovq
begin
memreg[W_rA] <= W_valM;
end

else if((W_iCode>4'b0111) & (W_iCode < 4'b1011))  // for call ret and pushq
begin
memreg[4] <= W_valE;
end

else if(W_iCode == 4'b1011)  // for popq
begin
memreg[4] <= W_valE;
memreg[W_rA] <=W_valM;
end

memreg0 <= memreg[0];
memreg1 <= memreg[1];
memreg2 <= memreg[2];
memreg3 <= memreg[3];
memreg4 <= memreg[4];
memreg5 <= memreg[5];
memreg6 <= memreg[6];
memreg7 <= memreg[7];
memreg8 <= memreg[8];
memreg9 <= memreg[9];
memreg10 <= memreg[10];
memreg11 <= memreg[11];
memreg12 <= memreg[12];
memreg13 <= memreg[13];
memreg14 <= memreg[14];

end
endmodule
  




                 
 
