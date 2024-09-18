module BIST (
	
    input clk,
    input reset,
    input [2:0] ALU_Sel,
    output match
);
    wire [7:0] A, B;
    wire [7:0] ALU_Out;
    wire CarryOut;
    wire [8:0] rom_data;
    wire [8:0] alu_data;
    reg [7:0] address;
    
    // Pattern generators
    pattern_gen_A genA (
        .clk(clk),
        .reset(reset),
        .A(A)
    );

    pattern_gen_B genB (
        .clk(clk),
        .reset(reset),
        .B(B)
    );

    // ALU instance
    alu alu_instance (
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .ALU_Out(ALU_Out),
        .CarryOut(CarryOut)
    );

    // Combine ALU_Out and CarryOut into a single 9-bit value
    assign alu_data = {ALU_Out, CarryOut};

    // ROM instance
    ROM rom_inst (
        .address(address),
        .data(rom_data)
    );

    // Address counter to iterate through ROM
    always @(posedge clk or posedge reset) begin
        if (reset)
            address <= 8'b0;
        else
            address <= address + 1;
    end

    // Compare ALU output with ROM data
    assign match = (alu_data == rom_data);
endmodule




module ROM (
    input [7:0] address,         // 8-bit address input
    output reg [8:0] data        // 9-bit data output (8-bit ALU_Out + 1-bit CarryOut)
);
    reg [8:0] memory [0:255];    // ROM storage with 256 locations, each 9 bits wide

    initial begin
        $readmemb("alu_outputLFSR.mem", memory); // Initialize memory from rom_data.mem file
    end

    always @(*) begin
        data = memory[address];  // Read data from memory based on address
    end
endmodule

module alu (
    input [7:0] A, B,  // ALU 8-bit Inputs                 
    input [2:0] ALU_Sel, // ALU Selection (3 bits now)
    output  [7:0] ALU_Out, // ALU 8-bit Output
    output CarryOut // Carry Out Flag
);
    reg [7:0] ALU_Result;
    wire [8:0] tmp;
    assign tmp = {1'b0, A} + {1'b0, B};

    always @(*) begin
        if (ALU_Sel == 3'b000) // Addition
            ALU_Result = A + B;
        else if (ALU_Sel == 3'b001) // Subtraction
            ALU_Result = A - B;
        else if (ALU_Sel == 3'b010) // Logical shift left
            ALU_Result = A << 1;
        else if (ALU_Sel == 3'b011) // Logical shift right
            ALU_Result = A >> 1;
        else if (ALU_Sel == 3'b100) // Rotate left
            ALU_Result = {A[6:0], A[7]};
        else if (ALU_Sel == 3'b101) // Rotate right
            ALU_Result = {A[0], A[7:1]};
        else if (ALU_Sel == 3'b110) // Logical and
            ALU_Result = A & B;
        else if (ALU_Sel == 3'b111) // Logical or
            ALU_Result = A | B;
        else
            ALU_Result = 8'b00000000; // Default case
    end
    
    // Introduce a stuck-at fault for demonstration
    // Uncomment the following line to simulate a fault
   // assign ALU_Out = 8'b00000000; // Faulty output
    assign #5 ALU_Out = ALU_Result;

    assign #5 CarryOut = tmp[8];
endmodule




module pattern_gen_A (
    input clk,
    input reset,
    output [7:0] A
);
    
		reg [7:0] Ain=8'b00000010;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Ain <= 8'b00000010;
        end else begin
  Ain[0] <= ((Ain[5] ^ Ain[7]) ^ Ain[4]) ^ Ain[3];
  Ain[1] <= Ain[0];
  Ain[2] <= Ain[1];
  Ain[3] <= Ain[2];
  Ain[4] <= Ain[3];
  Ain[5] <= Ain[4];
  Ain[6] <= Ain[5];
  Ain[7] <= Ain[6];
  
        end
    end
	 assign A=Ain;
endmodule

module pattern_gen_B (
    input clk,
    input reset,
    output  [7:0] B
);
    
	reg [7:0] Bin=8'b00000001;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
           Bin <= 8'b00000001;
        end else   begin
         Bin[0] <= ((Bin[5] ^ Bin[7]) ^ Bin[4]) ^ Bin[3];
  Bin[1] <= Bin[0];
  Bin[2] <= Bin[1];
  Bin[3] <= Bin[2];
  Bin[4] <= Bin[3];
  Bin[5] <= Bin[4];
  Bin[6] <= Bin[5];
  Bin[7] <= Bin[6];
        end
    end
	 assign B=Bin;
endmodule


