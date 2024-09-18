module bist_tb;

    reg clk;
    reg reset;
    reg [2:0] ALU_Sel;
    wire match;

    wire [7:0] A, B;
    wire [7:0] ALU_Out;
    wire CarryOut;
    wire [8:0] rom_data;
    wire [8:0] alu_data;
    reg [7:0] address;
    integer seq_count;

    // Instantiate pattern generators
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

    // Instantiate ALU instance
    alu alu_instance (
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .ALU_Out(ALU_Out),
        .CarryOut(CarryOut)
    );

    // Combine ALU_Out and CarryOut into a single 9-bit value
    assign alu_data = {ALU_Out, CarryOut};

    // Instantiate ROM module
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

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Reset and ALU_Sel cycling
    initial begin
        // Initialize inputs
        reset = 1;
        ALU_Sel = 3'b000;

        // Wait for global reset
        #10;
        reset = 0;
    end

    // ALU_Sel cycling
    always @(posedge clk) begin
        if (!reset)
            ALU_Sel <= ALU_Sel + 1;
    end

    // Sequence counter initialization
    initial begin
        seq_count = 0;
    end

    // Checking and displaying results
    always @(posedge clk) begin
        if (!reset) begin
            if (ALU_Out !== rom_data[8:1] || CarryOut !== rom_data[0]) begin
                $display("FAIL at %d: ALU_Sel=%b, A=%b, B=%b, Generated ALU_Out=%b, Expected ALU_Out=%b, Generated CarryOut=%b, Expected CarryOut=%b", 
                         seq_count, ALU_Sel, A, B, ALU_Out, rom_data[8:1], CarryOut, rom_data[0]);
            end else begin
                $display("PASS at %d: ALU_Sel=%b, A=%b, B=%b, Generated ALU_Out=%b, Expected ALU_Out=%b, Generated CarryOut=%b, Expected CarryOut=%b", 
                         seq_count, ALU_Sel, A, B, ALU_Out, rom_data[8:1], CarryOut, rom_data[0]);
            end

            seq_count = seq_count + 1; // Increment sequence count
        end
    end
endmodule
