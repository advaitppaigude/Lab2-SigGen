

module sinegen #(
    parameter WIDTH = 8
) (
    input logic clk,
    input logic [7:0] incr,
    input logic rst,
    input logic en,
    output logic [7:0] dout
);

    logic [7:0] addr;

    counter ctr(.clk(clk), .rst(rst), .en(en), .incr(incr), .count(addr));

    rom r(.clk(clk), .addr(addr), .dout(dout));


endmodule