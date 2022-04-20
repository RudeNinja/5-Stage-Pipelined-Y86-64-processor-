module pc_update_test;
     pc_update DUT(.clk(clk),.icode(icode),.cnd(cnd),.valC(valC),.valM(valM),.valP(valP),.PC_updated(PC_updated));
reg clk;
reg [3:0] icode;
reg cnd;
reg [63:0] valC;
reg [63:0] valM;
reg [63:0] valP;
wire [63:0] PC_updated;
initial
        begin
        $monitor ($time ," clk=%d,icode=%d,cnd=%d valC=%d valM=%d valP=%d PC_updated=%d",clk,icode,cnd,valC,valM,valP,PC_updated);
        $dumpfile ("pc_update_test1.vcd");
        $dumpvars (0,pc_update_test);
        clk=1;icode=4'b0010;cnd=0;valP=10;
        #5 clk=1;icode=4'b1001;valP=12;valM=20;
        #5 clk=1;icode=4'b1000;valP=15;valC=13;valM=25;
        #5 clk=1;icode=4'b0111;valP=9;valC=6;valM=19;cnd=0;
        #5 cnd=1;
       end
endmodule       
