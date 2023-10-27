module sigdelay #(
    parameter   DATA_WIDTH = 8,
    parameter   ADDRESS_WIDTH = 8
)(
    input logic         clk,
    input logic         rst,
    input logic         wr,
    input logic         rd,
    input logic     [ADDRESS_WIDTH-1:0] offset,
    input logic     [DATA_WIDTH-1:0]    mic_signal,
    output logic    [DATA_WIDTH-1:0]    delayed_signal
);

logic [ADDRESS_WIDTH-1:0] addr;

counter counter (
    .clk(clk),
    .en(wr | rd),
    .rst(rst),
    .count(addr)
);

ram2ports ram (
    .clk(clk),
    .wr_en(wr),
    .rd_en(rd),
    .wr_addr(addr + offset),
    .rd_addr(addr),
    .din(mic_signal),
    .dout(delayed_signal)
);

endmodule
