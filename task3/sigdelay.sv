module sigdelay #(
    parameter ADDRESS_WIDTH = 9,
              DATA_WIDTH = 8
)(
    input logic clk,
    input logic rst,
    input logic wr,
    input logic rd,
    input logic [ADDRESS_WIDTH-1:0] offset,
    input logic [DATA_WIDTH-1:0] mic_signal,
    output logic [DATA_WIDTH-1:0] delayed_signal
);

    logic [ADDRESS_WIDTH-1:0] rd_addr;
    logic [ADDRESS_WIDTH-1:0] wr_addr;

    ram #(.ADDRESS_WIDTH(ADDRESS_WIDTH), .DATA_WIDTH(DATA_WIDTH)) my_ram(
        .clk(clk),
        .wr_en(wr),
        .rd_en(rd),
        .wr_addr(wr_addr),
        .rd_addr(rd_addr),
        .din(mic_signal),
        .dout(delayed_signal)
    );

    always_ff @(posedge clk) begin
        if (rst) begin
            wr_addr <= 0;
        end
        else begin
            wr_addr <= wr_addr + {{ADDRESS_WIDTH-1{1'b0}}, wr};
        end
    end
    assign rd_addr = wr_addr - offset;

endmodule
