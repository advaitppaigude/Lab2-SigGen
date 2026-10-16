module sinegen #(
    parameter WIDTH = 8
) (
    input logic clk,
    input logic [7:0] delta,
    input logic rst,
    input logic en,
    output logic [7:0] dout1,
    output logic [7:0] dout2
);

    logic [7:0] addr1;
    logic [7:0] addr2;

    counter ctr(.clk(clk), .rst(rst), .en(en), .delta(delta), .count1(addr1), .count2(addr2));

    rom r(.clk(clk), .addr1(addr1), .addr2(addr2), .dout1(dout1), .dout2(dout2));


endmodule
