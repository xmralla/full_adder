module full_adder8 #(W = 8) (
input                clk,
input                resetn,
input [W-1:0]        a,
input [W-1:0]        b,
input                c,
output logic [W-1:0] S,
output logic         C
);

reg [W:0] r;

always_ff @(posedge clk)
    if(!resetn)
        r <= 0;
    else
        r <= a + b + c;

assign S = r[W-1:0];
assign C = r[W];

endmodule

module full_adder #(W = 64) (
input                clk,
input                resetn,
input [W-1:0]        a,
input [W-1:0]        b,
input                c,
output logic [W-1:0] S,
output logic         C
);
localparam n = W / 8;

wire [7:0] ai[n];
wire [7:0] bi[n];
wire       ci[n];
wire [7:0] Si[n];
wire       Ci[n];

generate
genvar i;
for (i = 0; i < n; i++) begin
    assign ai[i] = a[(i + 1)*8-1:i*8];
    assign bi[i] = b[(i + 1)*8-1:i*8];
    if (i == 0)
        assign ci[i] = c;//a[(i + 1)*8-1:i*8];
    else
        assign ci[i] = Ci[i-1];//a[(i + 1)*8-1:i*8];
    assign S[(i + 1)*8-1:i*8] = Si[i];

    full_adder8 adder(
        .clk(clk),
        .resetn(resetn),
        .a(ai[i]),
        .b(bi[i]),
        .c(ci[i]),
        .S(Si[i]),
        .C(Ci[i])
    );
end
endgenerate

endmodule
