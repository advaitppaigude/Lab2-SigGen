module counter(
    input logic clk,
    input logic rst,
    input logic en,
    input logic [7:0] delta,
    output logic [7:0] count1,
    output logic [7:0] count2
);

    always_ff @(posedge clk) begin
        if (rst) begin
            count1 <= 8'd0;
            count2 <= 8'd0;
        end
        else begin
            count1 <= count1 + {{7{1'b0}}, en};
            count2 <= count1 + {{7{1'b0}}, en} + delta;
        end
    end

endmodule
