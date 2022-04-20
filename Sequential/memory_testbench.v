module memory_test;
    memory DUT(.clk(clk),.icode(icode),.valA(valA),.valE(valE),.valP(valP),
               .valM(valM),.data_memory_error(data_memory_error));
    reg  clk;
    reg [3:0] icode;
    reg signed [63:0] valA;
    reg signed [63:0] valE;
    reg signed [63:0] valP;

    wire [63:0] valM;
    wire data_memory_error;
    initial
        begin
            $monitor ($time ,"clk=%d, icode=%d,valA=%d,valE=%d,valP=%d,valM=%d,data_memory_error=%d",clk,icode,valA,valE,valP,valM,data_memory_error);
            $dumpfile ("memory_test.vcd");
            $dumpvars (0,memory_test);  
            clk=1;icode=4'b0100;valA=64'd20;valE=64'd50;valP=64'd70; 
            #5clk=1;icode=4'b0100;valA=64'd30;valE=-64'd50;valP=64'd70; 
            #5clk=1;icode=4'b1001;valA=64'd50;
        end
endmodule            