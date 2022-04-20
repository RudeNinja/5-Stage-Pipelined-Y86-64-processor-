module F(clk , pred_PC , F_predPC);
input clk;
input [63:0] pred_PC;
output reg[63:0] F_predPC;

always@(posedge clk)
begin
    F_predPC <= pred_PC;

end

endmodule
