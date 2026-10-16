module ram #(
    parameter ADDRESS_WIDTH = 9,
              DATA_WIDTH = 8
)(
    input logic clk,
    input logic wr_en,
    input logic rd_en,
    input logic [ADDRESS_WIDTH-1:0] wr_addr,
    input logic [ADDRESS_WIDTH-1:0] rd_addr,
    input logic [DATA_WIDTH-1:0] din,
    output logic [DATA_WIDTH-1:0] dout
);

    logic [DATA_WIDTH-1:0] mem [2**ADDRESS_WIDTH-1:0];
    always_ff @(posedge clk) begin
        if (wr_en) begin
            mem[wr_addr] <= din;
        end
        if (rd_en) begin
            dout <= mem[rd_addr];
        end
    end


endmodule
