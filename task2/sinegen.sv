module sinegen #(
    parameter   A_WIDTH = 8,
                D_WIDTH = 8
)(
    input logic                 clk,
    input logic                 rst,
    input logic                 en,
    input logic [D_WIDTH-1:0]   phase,
    output logic [D_WIDTH-1:0]  dout1,
    output logic [D_WIDTH-1:0]  dout2
);

    logic   [A_WIDTH-1:0]       address;

counter addrCounter (
    .clk(clk),
    .rst(rst),
    .en(en),
    .count(address)
);

rom sineRom1(
    .clk(clk),
    .addr(address),
    .dout(dout1)
);

rom sineRom2(
    .clk(clk),
    .addr(address + phase),
    .dout(dout2)
);

endmodule

