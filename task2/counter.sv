module counter #(
    parameter WIDTH = 8
)(
    input logic                 clk,    // clock (duh)
    input logic                 rst,    // reset
    input logic                 en,     // count direction
    output logic[WIDTH-1:0]     count   // count output
);

always_ff @(posedge clk, posedge rst) // CHALLENGE asynchronous reset
    if (rst) count <= {WIDTH{1'b0}};
    else count <= count + {{WIDTH-1{1'b0}},en}; 

endmodule
