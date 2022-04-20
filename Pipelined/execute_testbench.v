module execute_test;
    execute DUT(
    .clk(clk),.icode(icode),.ifun(ifun),.valA(valA),.valB(valB),.valC(valC),
    .cnd(cnd),.valE(valE),.cc(cc)
    );
reg  clk;
reg [3:0] icode;
reg [3:0] ifun;
reg signed [63:0] valA;
reg signed [63:0] valB;
reg signed [63:0] valC;

wire cnd;
wire signed [63:0] valE;
wire [2:0] cc;

initial
        begin
            $monitor ($time ,"clk=%d, icode=%d,ifun=%d,valA=%d,valB=%d,valC=%d,cnd=%d,valE=%d,cc=%b",clk,icode,ifun,valA,valB,valC,cnd,valE,cc);
            $dumpfile ("execute_test.vcd");
            $dumpvars (0,execute_test);
           clk=1;icode=4'b0010;ifun=4'b0000;valA=64'd20;valB=-64'd50;valC=64'd70;
           #5 clk=1;icode=4'b0010;ifun=4'b0001;valA=-64'd20;valB=64'd50;valC=64'd70;
           #5 clk=1;icode=4'b0010;ifun=4'b0010;valA=64'd50;valB=64'd50;valC=64'd50;
           #5 clk=1;icode=4'b0010;ifun=4'b0011;valA=64'd20;valB=-64'd50;valC=-64'd20;
           #5 clk=1;icode=4'b0010;ifun=4'b0100;valA=64'd20;valB=64'd50;valC=-64'd20;
           #5 clk=1;icode=4'b0010;ifun=4'b0101;valA=64'd20;valB=-64'd50;valC=-64'd20;
           #5 clk=1;icode=4'b0011;ifun=4'b0000;valA=64'd20;valB=64'd50;valC=-64'd40;
           #5 clk=1;icode=4'b0100;ifun=4'b0000;valA=64'd20;valB=-64'd50;valC=-64'd80;
           #5 clk=1;icode=4'b0101;ifun=4'b0000;valA=64'd20;valB=64'd50;valC=64'd20;
           #5 clk=1;icode=4'b0110;ifun=4'b0000;valA=64'd20;valB=-64'd50;valC=-64'd10;
           #5 clk=1;icode=4'b0110;ifun=4'b0001;valA=-64'd20;valB=64'd50;valC=64'd90;
           #5 clk=1;icode=4'b0110;ifun=4'b0010;valA=64'd20;valB=-64'd50;valC=-64'd40;
           #5 clk=1;icode=4'b0110;ifun=4'b0011;valA=64'd20;valB=64'd50;valC=64'd60;
           #5 clk=1;icode=4'b0111;ifun=4'b0000;valA=64'd20;valB=-64'd50;valC=-64'd20;
           #5 clk=1;icode=4'b0111;ifun=4'b0001;valA=64'd70;valB=64'd50;valC=64'd20;
           #5 clk=1;icode=4'b0111;ifun=4'b0010;valA=-64'd20;valB=-64'd50;valC=-64'd40;
           #5 clk=1;icode=4'b0111;ifun=4'b0011;valA=64'd80;valB=64'd50;valC=64'd60;
           #5 clk=1;icode=4'b0111;ifun=4'b0100;valA=64'd90;valB=-64'd50;valC=-64'd30;
           #5 clk=1;icode=4'b0111;ifun=4'b0101;valA=64'd40;valB=64'd50;valC=64'd35;
           #5 clk=1;icode=4'b0111;ifun=4'b0110;valA=-64'd60;valB=-64'd50;valC=-64'd75;
           #5 clk=1;icode=4'b1000;ifun=4'b0000;valA=64'd20;valB=64'd50;valC=64'd63;
           #5 clk=1;icode=4'b1001;ifun=4'b0000;valA=64'd40;valB=-64'd50;valC=-64'd72;
           #5 clk=1;icode=4'b1010;ifun=4'b0000;valA=64'd20;valB=64'd50;valC=64'd42;
           #5 clk=1;icode=4'b1011;ifun=4'b0000;valA=-64'd250;valB=-64'd50;valC=-64'd12;

        #5clk=1;icode=4'b0010;ifun=4'b0001;valA=64'd20;valB=-64'd20;valC=64'd70;
        #5 clk=1;icode=4'b0010;ifun=4'b0001;valA=64'd20;valB=-64'd20;valC=64'd70;


             
        end
endmodule        