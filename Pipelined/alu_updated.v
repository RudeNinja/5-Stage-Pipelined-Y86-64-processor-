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