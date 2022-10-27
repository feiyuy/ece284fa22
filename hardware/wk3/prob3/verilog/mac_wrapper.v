// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module mac_wrapper (clk, out, a, b, c);

parameter bw = 4;
parameter psum_bw = 16;

output [psum_bw-1:0] out;
input  [bw-1:0] a;
input  [bw-1:0] b;
input  [psum_bw-1:0] c;
input  clk;

reg    [bw-1:0] a_q;
reg    [bw-1:0] b_q;
reg    [psum_bw-1:0] c_q;

mac #(.DATA_WIDTH(bw), .SUM_WIDTH(psum_bw)) mac_instance (
        .data_in(a_q), 
        .weight_in(b_q),
        .acc_in(c_q),
	.acc_out(out)
); 

always @ (posedge clk) begin
        b_q  <= b;
        a_q  <= a;
        c_q  <= c;
end

endmodule
