module counter(
    input logic clk,
    input logic rst,
    input logic en,
    input logic [7:0] incr,
    output logic [7:0] count
);

    always_ff @(posedge clk) begin
        if (rst) begin
            count <= 8'd0;
        end
        else begin
            count <= count + {incr & {8{en}}};
        end
    end

endmodule

