 module memory(clk,icode,valA,valE,valP,valM,data_memory_error);
 input clk;
 input [3:0] icode;
 input [63:0] valA;
 input [63:0] valE;
 input [63:0] valP;
 output reg [63:0] valM;
 output reg data_memory_error;

 reg [63:0] data_memory[1023:0];

 initial valM=64'b0;
   
 always @(*)
    begin
        data_memory_error=0;
        //rmmovq
        if(icode==4'b0100)
            begin
                if((valE>1023)||(valE<0))
                    data_memory_error=1;
                else    
                    data_memory[valE]=valA;
            end
        //mrmovq   
        else if(icode==4'b0101)
            begin
                if((valE>1023)||(valE<0))
                    data_memory_error=1;
                else    
                    valM=data_memory[valE];
            end
        //call
        else if(icode==4'b1000)
            begin
                if((valE>1023)||(valE<0))
                    data_memory_error=1;
                else    
                    data_memory[valE]=valP;
            end 
        //ret           
        else if(icode==4'b1001)
            begin
                if((valA>1023)||(valA<0))
                    data_memory_error=1;
                else    
                valM=data_memory[valA];    
            end   
        //pushq
        else if(icode==4'b1010)
            begin
                if((valE>1023)||(valE<0))
                    data_memory_error=1;
                else
                data_memory[valE]=valA;
            end  
        //popq      
        else if(icode==4'b1011)
            begin
                if((valA>1023)||(valA<0))
                    data_memory_error=1;
                else  
                    valM=data_memory[valA];
            end        
    end 
endmodule    






