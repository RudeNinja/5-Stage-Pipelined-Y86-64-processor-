module wb(clk,iCode,rA,rB,valE,valM,memreg0,memreg1,memreg2,memreg3,memreg4,memreg5,memreg6,memreg7,memreg8,
memreg9,memreg10,memreg11,memreg12,memreg13,memreg14);

input clk;
input[3:0] iCode, rA , rB;
input[63:0] valE,valM;
output reg[63:0] memreg0,memreg1,memreg2,memreg3,memreg4,memreg5,memreg6,memreg7,memreg8,
memreg9,memreg10,memreg11,memreg12,memreg13,memreg14;

reg [63:0] memreg[0:14];

integer i;

initial begin
for(i=0;i<15;i=i+1)
begin
memreg[i] = 64'd0+i;
end
end

always@(*)

begin

if((iCode == 4'b0010) || (iCode == 4'b0011) ||(iCode==4'b0110)) // for cmovxx, irmovq and OPq
begin
memreg[rB] <= valE;
end

else if (iCode ==4'b0101)  // for mrmovq
begin
memreg[rA] <= valM;
end

else if((iCode>4'b0111) & (iCode < 4'b1011))  // for call ret and pushq
begin
memreg[4] <= valE;
end

else if(iCode == 4'b1011)  // for popq
begin
memreg[4] <= valE;
memreg[rA] <=valM;
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

