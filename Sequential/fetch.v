module fetch(clk, PC, rA , rB , iCode , iFun ,valC,valP,instr_Validity, imem_error,HF);

// PORT DECLARATION
parameter N = 511;
input [63:0] PC;
input clk;
output reg[3:0] iCode,iFun,rA,rB; // instruction
output reg[63:0] valC,valP;  // values to be assigned for op and PC update
output reg instr_Validity,imem_error,HF; // Validity and memory overflow flag and halt flag 'HF' to distinguish between 
                                         //                                         HALT and NOop.

reg [7:0] InstructionMemory [0:N]; // Can take 511 single byte instructions at a time.

reg [0:79]Instruction;

initial begin
    // //   //mrmovq $0x10, %rdx
   InstructionMemory[10]=8'b01000000; //4 0   PC = 10
   InstructionMemory[11]=8'b00000010; //rA=0 rB=2
   InstructionMemory[12]=8'b00000000;           
   InstructionMemory[13]=8'b00000000;           
   InstructionMemory[14]=8'b00000000;           
   InstructionMemory[15]=8'b00000000;           
   InstructionMemory[16]=8'b00000000;           
   InstructionMemory[17]=8'b00000000;           
   InstructionMemory[18]=8'b00000000;          
   InstructionMemory[19]=8'b00010000; //V=16


   // OPq addq
   InstructionMemory[29]=8'b01100000; // 6 0  (add)   // PC = 29
   InstructionMemory[30]=8'b00010010; // 1 2  %rcx %rdx
   
   

   //jxx
   InstructionMemory[20]=8'b01110000; //7 0   (jmp)  // PC  = 20;
   InstructionMemory[21]=8'b00000000; 
   InstructionMemory[22]=8'b00000000;           
   InstructionMemory[23]=8'b00000000;           
   InstructionMemory[24]=8'b00000000;           
   InstructionMemory[25]=8'b00000000;           
   InstructionMemory[26]=8'b00000000;           
   InstructionMemory[27]=8'b00000000;           
   InstructionMemory[28]=8'b00010000; //dest = 16
   
   //call
   InstructionMemory[31]=8'b10000000; // 80 (call) // PC =31
   InstructionMemory[32]=8'b00000000; 
   InstructionMemory[33]=8'b00000000; 
   InstructionMemory[34]=8'b00000000; 
   InstructionMemory[35]=8'b00000000;
   InstructionMemory[36]=8'b00000000; 
   InstructionMemory[37]=8'b00000000; 
   InstructionMemory[38]=8'b00000000; 
   InstructionMemory[39]=8'b01000000;  // dest
   
     
   
end



always@(posedge clk)
 begin

                Instruction = {InstructionMemory[PC],InstructionMemory[PC+1],
                               InstructionMemory[PC+2],InstructionMemory[PC+3],
                               InstructionMemory[PC+4],InstructionMemory[PC+5],
                               InstructionMemory[PC+6],InstructionMemory[PC+7],
                               InstructionMemory[PC+8],InstructionMemory[PC+9]
                               }; // Concatenating the Instruction memory to make a single 10 byte instruction.
 
     instr_Validity = 1'b1;
     if(PC>N)
     begin
         imem_error =1;  // Checking for Memory Overflow; assign 1 if TRUE;
     end

     else
     begin
            imem_error =0;  // Assign 0 if FALSE
     end
     iCode = Instruction[0:3];
     iFun  = Instruction[4:7];
     HF = 1'b0;
     if((iCode==4'b0000) & (iFun==4'b0000) ) // Halt ;
     begin
         valP = PC+64'd1;
         HF = 1'b1;
     end

     else if ((iCode==4'b0001)&(iFun==4'b0000)) begin
         valP = PC+64'd1;
     end

     else if((iCode==4'b0010)&(iFun<4'b0111)) // ccmovxx
     begin
         rA = Instruction[8:11];
         rB = Instruction[12:15];
         valP = PC + 64'd2;
     end

     else if ((iCode==4'b0011)&(iFun==4'b0000))//irmovq
     begin  
         rA = Instruction[8:11];
         rB = Instruction[12:15];
         valC = Instruction[16:79];           // Stores immediate value to be moved
         valP = PC+64'd10;
         
     end

     else if((iCode==4'b0100)&(iFun==4'b0000)) //rmmovq
       begin
         rA = Instruction[8:11];
         rB = Instruction[12:15];
         valC = Instruction[16:79];           // Stores Displacement value
         valP = PC+64'd10;
       end

     else if ((iCode==4'b0101)&(iFun==4'b0000)) //mrmovq
     begin
         rA = Instruction[8:11];
         rB = Instruction[12:15];
         valC = Instruction[16:79];           // Stores Displacement value
         valP = PC+ 64'd10;    
     end

     else if ((iCode==4'b0110) & (iFun<4'b0100))         //OPq
     begin
         if ((iFun==4'b0000)) 
         begin                                          //addq
             rA = Instruction[8:11];
             rB = Instruction[12:15];
             valP = PC + 64'd2;
         end

         else if (iFun==4'b0001) 
         begin                                          //subq
             rA = Instruction[8:11];
             rB = Instruction[12:15];
             valP = PC + 64'd2;
         end

         else if (iFun==4'b0010) 
         begin                                          //andq
             rA = Instruction[8:11];
             rB = Instruction[12:15];
             valP = PC + 64'd2;
         end

         else if (iFun==4'b0011) 
         begin                                          //xorq
             rA = Instruction[8:11];
             rB = Instruction[12:15];
             valP = PC + 64'd2;
         end
     end

   else if ((iCode==4'b0111) & (iFun<4'b0111))          // jxx  Instruction size is of 9 bytes for jump intsruction. 
     begin
            
             valC = Instruction[8:71];  // stores destination 
             valP = PC + 64'd9;
     end

     else if ((iCode==4'b1000)&(iFun==4'b0000))        // call 
     begin
             
             valC = Instruction[8:71];
             valP = PC + 64'd9;
     end

     else if((iCode==4'b1001)&(iFun==4'b0000))         //return (ret)
     begin
             valP = PC + 64'd1;    
     end

     else if((iCode==4'b1010)&(iFun==4'b0000))         //pushq 
     begin
             rA = Instruction[8:11];
             rB = Instruction[12:15];
             valP = PC + 64'd2;
     end

     else if((iCode==4'b1011)&(iFun==4'b0000))         //popq 
     begin
             rA = Instruction[8:11];
             rB = Instruction[12:15];
             valP = PC + 64'd2;
     end

     else 
     begin
             instr_Validity = 1'b0;                       // If any other combination is entered its invalid;    
     end
 end

endmodule

     




