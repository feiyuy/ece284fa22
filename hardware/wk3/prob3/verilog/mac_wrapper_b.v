// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module mac_wrapper_b (clk, out, a0, b0,a1, b1, a2, b2, a3, b3, c);

parameter bw = 4;
parameter psum_bw = 16;

output [psum_bw-1:0] out;
input  [bw-1:0] a0;
input  [bw-1:0] b0;
input  [bw-1:0] a1;
input  [bw-1:0] b1;
input  [bw-1:0] a2;
input  [bw-1:0] b2;
input  [bw-1:0] a3;
input  [bw-1:0] b3;
input  [psum_bw-1:0] c;
input  clk;

reg    [bw-1:0] a0_q;
reg    [bw-1:0] b0_q;
reg    [bw-1:0] a1_q;
reg    [bw-1:0] b1_q;
reg    [bw-1:0] a2_q;
reg    [bw-1:0] b2_q;
reg    [bw-1:0] a3_q;
reg    [bw-1:0] b3_q;
reg    [psum_bw-1:0] c_q;

mac #(.DATA_WIDTH(bw), .SUM_WIDTH(psum_bw)) mac_instance (
        .data0_in(a0_q), 
        .weight0_in(b0_q),
        .data1_in(a1_q), 
        .weight1_in(b1_q),
        .data2_in(a2_q), 
        .weight2_in(b2_q),
        .data3_in(a3_q), 
        .weight3_in(b3_q),
        .acc_in(c_q),
	.acc_out(out)
); 

always @ (posedge clk) begin
        b0_q  <= b0;
        a0_q  <= a0;
        b1_q  <= b1;
        a1_q  <= a1;
        b2_q  <= b2;
        a2_q  <= a2;
        b3_q  <= b3;
        a3_q  <= a3;
        c_q  <= c;
end

endmodule
