module decode(clk,iCode,rA,rB,reg_stackA,reg_stackB,reg_stack4,valA,valB);

input clk;
input[3:0] iCode , rA , rB;
input[63:0]reg_stackA , reg_stackB , reg_stack4 ; // registers storing valA, valB and stack pointer respectively.

output reg[63:0] valA , valB;

always@(posedge clk)
begin
if(iCode==4'b0010)
begin
valA <= reg_stackA;
end

if(iCode==4'b0100) //rmmovq
    begin
      valA<=reg_stackA;
      valB<=reg_stackB;
    end
    if(iCode==4'b0101) //mrmovq
    begin
      valB=reg_stackB;
    end
    if(iCode==4'b0110) //OPq
    begin
      valA<=reg_stackA;
      valB<=reg_stackB;
    end
    // if(iCode==4'b0111) //jxx
    // begin
    // end
    if(iCode==4'b1000) //call
    begin
      valB<=reg_stack4; //rsp
    end
    if(iCode==4'b1001) //ret
    begin
      valA<=reg_stack4; //rsp
      valB<=reg_stack4; //rsp
    end
    if(iCode==4'b1010) //pushq
    begin
      valA<=reg_stackA;
      valB<=reg_stack4; //rsp
    end
    if(iCode==4'b1011) //popq
    begin
      valA<=reg_stack4; //rsp
      valB<=reg_stack4; //rsp
    end
  end

endmodule


