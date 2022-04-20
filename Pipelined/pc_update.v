module pc_update(clk,icode,cnd,valC,valM,valP,PC_updated);
input clk;
input [3:0] icode;
input cnd;
input [63:0] valC;
input [63:0] valM;
input [63:0] valP;

output reg [63:0] PC_updated;

always @(*)
   begin
        if(icode==4'b0010||icode==4'b0011||icode==4'b0100||icode==4'b0101||icode==4'b0110||icode==4'b1010||icode==4'b1011)
            PC_updated=valP;
        else if(icode==4'b0111)
            PC_updated=cnd?valC:valP;
        else if(icode==4'b1000)
            PC_updated=valC;
        else if(icode==4'b1001)
            PC_updated=valM;
   end
endmodule   


       


