module execute(clk,icode,ifun,valA,valB,valC,cnd,e_dstE,valE,cc,rA,rB);
//inputs Declaration
input  clk;
input [3:0] icode;
input [3:0] ifun,rA,rB;
input  signed [63:0] valA;
input  signed [63:0] valB;
input signed [63:0] valC;

//Outputs Declaration
output reg signed  [63:0] valE;
output reg cnd;
output reg [2:0] cc;
output reg [3:0] e_dstE;

reg [3:0] icd;
reg signed [63:0] x;
reg signed [63:0] y;
reg [1:0]  control;
wire signed [63:0] z;
wire zf;
wire sf;
wire of;

reg not_input;
reg or_input1;
reg or_input2;
reg xor_input1;
reg xor_input2;

wire not_output;
wire or_output;
wire xor_output;
 

ALU_final alu(icd,x,y,control,z,zf,sf,of);
always @(z)
    valE=z;
always @(zf,sf,of)
    begin
        cc[0]=zf;
        cc[1]=sf;
        cc[2]=of;
    end




not notgate(not_output,not_input);
or  orgate(or_output,or_input1,or_input2);
xor xor_gate(xor_output,xor_input1,xor_input2);




always @(*)
    begin
        if(clk==1)
            begin
            cnd=0;
            //cmovxx
            if(icode==4'b0010)
                begin
                    x=valA;
                    y=valB;
                    icd=icode;
                    control=2'b00;
                    //rrmovq
                    if(ifun==4'b0000)
                    begin
                        cnd=1;
                    end
                    //cmovle
                    else if(ifun==4'b0001)
                        begin
                            // (sf^of)||zf
                            xor_input1=cc[1];
                            xor_input2=cc[2];
                            or_input1=xor_output;
                            or_input2=cc[0];
                            if(or_output)
                                begin
                                    cnd=1;
                                end 
                        end
                    //cmovl    
                    else if(ifun==4'b0010)
                        begin
                            // sf^of
                            xor_input1=cc[1];
                            xor_input2=cc[2];
                            if(xor_output)
                                begin
                                    cnd=1;
                                end    
                        end  
                    //cmove    
                    else if(ifun==4'b0011)
                        begin
                            // zf
                            if(cc[0])
                                begin
                                    cnd=1;
                                end
                        end         
                    //cmovne    
                    else if(ifun==4'b0100)
                        begin
                            // !zf
                            not_input=cc[0];
                            if(not_output)
                                begin
                                    cnd=1;
                                end
                        end
                     //cmovge   
                    else if(ifun==4'b0101)
                        begin
                            // !(sf^of)
                            xor_input1=cc[1];
                            xor_input2=cc[2];
                            not_input=xor_output;
                            if(not_output)
                                begin
                                    cnd=1;
                                end
                        end            
                    //cmovg
                    else if(ifun==4'b0110)
                        begin
                            //!(sf^of)) && (!zf)
                            xor_input1=cc[1];
                            xor_input2=cc[2];
                            not_input=xor_output;
                            if(not_output)
                                begin
                                    not_input=cc[0];
                                    if(not_output)
                                        begin
                                            cnd=1;
                                        end    
                                end
                        end
                end 
            //irmovq
            else if(icode==4'b0011)
                begin
                    x=valC;
                    y=64'b0;
                    icd=icode;
                    control=2'b00;
                   
                end
            //rmmovq
            else if(icode==4'b0100)
                begin
                icd=icode;
                    x=valC;
                    y=valB;
                    control=2'b00;
                    
                end
            //mrmovq
            else if(icode==4'b0101)
                begin
                    icd=icode;
                    x=valC;
                    y=valB;
                    
                end
            //Arithmatic and logic Operations
            else if(icode==4'b0110)
                begin
                    x=valA;
                    y=valB;
                    icd=icode;
                    control=2'b00;
                    //add 
                    if(ifun==4'b0000)
                        begin
                            control=2'b00;
                        end
                    //sub
                    else if(ifun==4'b0001)
                        begin
                            control=2'b01;
                        end 
                    //and       
                    else if(ifun==4'b0010)
                        begin
                            control=2'b10;
                        end 
                    //xor    
                    else if(ifun==4'b0011)
                        begin
                            control=2'b11;
                        end     
                                  
                    
                end
             //call   
             else if(icode==4'b1000) 
                 begin
                    x=-64'b1;
                    y=valB;
                    icd=icode;
                    control=2'b00;
                  
                 end
            //ret     
            else if(icode==4'b1001)
                begin
                    x=64'b1;
                    y=valB;
                    icd=icode;
                    control=2'b00;
               
                end
            //pushq    
            else if(icode==4'b1010)
                begin
                    x=-64'b1;
                    y=valB;
                    icd=icode;
                    control=2'b00;
       
                end
            //popq
            else if(icode==4'b1011)
                begin
                    x=64'b1;
                    y=valB;
                    icd=icode;
                    control=2'b00;
            
                end    
       
            //jxx    
            else if(icode==4'b0111)
                begin
                    //jmp
                    if(ifun==4'b0000)
                    begin
                        cnd=1;
                    end
                    //jle
                    else if(ifun==4'b0001)
                        begin
                            // (sf^of)||zf
                            xor_input1=cc[1];
                            xor_input2=cc[2];
                            or_input1=xor_output;
                            or_input2=cc[0];
                            if(or_output)
                                begin
                                    cnd=1;
                                end 
                        end
                    //jl    
                    else if(ifun==4'b0010)
                        begin
                            // sf^of
                            xor_input1=cc[1];
                            xor_input2=cc[2];
                            if(xor_output)
                                begin
                                    cnd=1;
                                end    
                        end  
                    //je   
                    else if(ifun==4'b0011)
                        begin
                            // zf
                            if(cc[0])
                                begin
                                    cnd=1;
                                end
                        end         
                    //jne    
                    else if(ifun==4'b0100)
                        begin
                            // !zf
                            not_input=cc[0];
                            if(not_output)
                                begin
                                    cnd=1;
                                end
                        end
                    //jge   
                    else if(ifun==4'b0101)
                        begin
                            // !(sf^of)
                            xor_input1=cc[0];
                            xor_input2=cc[1];
                            not_input=xor_output;
                            if(not_output)
                                begin
                                    cnd=1;
                                end
                        end            
                    //jg
                    else if(ifun==4'b0110)
                        begin
                            //!(sf^of)) && (!zf)
                            xor_input1=cc[1];
                            xor_input2=cc[2];
                            not_input=xor_output;
                            if(not_output)
                                begin
                                    not_input=cc[0];
                                    if(not_output)
                                        begin
                                            cnd=1;
                                        end    
                                end
                        end  
                end    
            end
            
            e_dstE = rB;
        
    end
endmodule


module ALU_final(icode,x,y,control,result,zf,sf,OF);
  input [3:0] icode;
  input signed[63:0] x,y;
  input [1:0] control;
  output reg signed[63:0] result;
  output reg zf;
  output reg sf;
  output reg OF;
  
  wire signed [63:0]ans1;
  wire signed [63:0]ans2;
  wire signed [63:0]ans3;
  wire signed [63:0]ans4;

  reg signed [63:0]ansfinal;
  reg overflowfinal;
  wire OF1,OF2;
  ADD g1(x,y,ans1,OF1); 
  SUB g2(x,y,ans2,OF2);
  AND g3(x,y,ans3);
  XOR g4(x,y,ans4);
 
  always @(*)
  begin
    case(control)
      2'b00:begin
          ansfinal=ans1;
          overflowfinal=OF1;
        end
      2'b01:begin
          ansfinal=ans2;
          overflowfinal=OF2;
        end    
      2'b10:begin
          ansfinal=ans3;
          overflowfinal=1'b0;
        end
      2'b11:begin
          ansfinal=ans4;
          overflowfinal=1'b0;
        end
    endcase
  end  
always @(*)
  result= ansfinal;
  
always @(*)
    begin
        if(icode==4'b0110)
            begin
                if(ansfinal==64'b0)
                    begin
                        zf=1;
                    end
                else
                    begin
                        zf=0;
                    end
               
                if(ansfinal[63]==1'b1)
                    begin
                        sf=1;
                    end
                else
                    begin
                        sf=0;
                    end                              
                OF= overflowfinal;
            end
    end        
endmodule

module XOR(x,y,z);
input [63:0] x,y;
output [63:0] z;

genvar i;

generate
for(i=0;i<64;i = i+1) begin

xor(z[i] , x[i] , y[i]);

end

endgenerate

endmodule

module AND(x,y,z);
input[0:63] x,y;
output[0:63]z;

genvar i;

generate

for(i=0;i<64;i = i+1) begin

and(z[i] , x[i] , y[i]);

end

endgenerate

endmodule

module ADD(x,y,sum,OF);
input signed[63:0] x,y;
output signed[63:0] sum;
output signed OF;
wire signed[63:0] ci;

wire carry_in;
assign carry_in = 1'b0;


full_adder FA1(x[0],y[0],carry_in,sum[0],ci[0]);
genvar i;
generate
for(i=1;i<64;i=i+1) 
begin
full_adder FA0(x[i] , y[i] , ci[i-1] , sum[i] , ci[i]);
end
endgenerate

xor(OF,ci[62],ci[63]);

endmodule

module full_adder(x,y,carry_in,sum,carry);
   input signed x,y,carry_in;
   output signed sum,carry;
   wire signed w1,w2,w3,w4,w5;
   xor(w1,x,y);
   xor(sum,w1,carry_in);
   and(w2,x,y);
   and(w3,x,carry_in);
   and(w4,y,carry_in);
   or(w5,w2,w3);
   or(carry,w5,w4);
endmodule

module  SUB(x,y,z,OF);
input signed[63:0] x,y;
output signed[63:0] z;
output OF;

wire signed[63:0] u,v,w;
wire signed[63:0] k;


twocomp comp(y , u);



ADD sub_add(x , u , w , OF);

assign z=w;

endmodule



module twocomp(x ,y);
input signed[63:0] x;
output signed[63:0] y;
wire signed[63:0] w;
wire c_out;
genvar i;
generate 
for(i=0 ; i<64 ; i = i+1) 
begin
not (w[i] , x[i]);
end
endgenerate
ADD twocomp1(w,64'b1,y,c_out);
endmodule
