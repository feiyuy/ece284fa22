// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 


module mac_tb_b;

parameter bw = 4;
parameter psum_bw = 16;

reg clk = 0;

reg  [bw-1:0] a0;
reg  [bw-1:0] b0;
reg  [bw-1:0] a1;
reg  [bw-1:0] b1;
reg  [bw-1:0] a2;
reg  [bw-1:0] b2;
reg  [bw-1:0] a3;
reg  [bw-1:0] b3;
reg  [psum_bw-1:0] c;
wire [psum_bw-1:0] out;
reg  [psum_bw-1:0] expected_out = 0;

integer w_file ; // file handler
integer w_scan_file ; // file handler

integer x_file ; // file handler
integer x_scan_file ; // file handler

integer x0_dec;
integer w0_dec;
integer x1_dec;
integer w1_dec;
integer x2_dec;
integer w2_dec;
integer x3_dec;
integer w3_dec;
integer i; 
integer u; 

function [3:0] w_bin ;
  input integer  weight ;
  begin

    if (weight>-1)
     w_bin[3] = 0;
    else begin
     w_bin[3] = 1;
     weight = weight + 8;
    end

    if (weight>3) begin
     w_bin[2] = 1;
     weight = weight - 4;
    end
    else 
     w_bin[2] = 0;

    if (weight>1) begin
     w_bin[1] = 1;
     weight = weight - 2;
    end
    else 
     w_bin[1] = 0;

    if (weight>0) 
     w_bin[0] = 1;
    else 
     w_bin[0] = 0;

  end
endfunction



function [3:0] x_bin ;
  input integer   data;
  begin
    if (data > 7) begin
      x_bin[3] = 1;
      data = data - 8;
    end
    else
      x_bin[3] = 0;
    if (data>3) begin
     x_bin[2] = 1;
     data = data - 4;
    end
    else 
     x_bin[2] = 0;

    if (data>1) begin
     x_bin[1] = 1;
     data = data - 2;
    end
    else 
     x_bin[1] = 0;

    if (data>0) 
     x_bin[0] = 1;
    else 
     x_bin[0] = 0;

  end
endfunction


// Below function is for verification
function [psum_bw-1:0] mac_predicted;
  input   [bw-1:0] a0;
  input   [bw-1:0] a1;
  input   [bw-1:0] a2;
  input   [bw-1:0] a3;
  input   signed [bw-1:0] b0;
  input   signed [bw-1:0] b1;
  input   signed [bw-1:0] b2;
  input   signed [bw-1:0] b3;
  input   signed [psum_bw-1:0] c;
  begin
    mac_predicted = a0 * b0 + a1 * b1 + a2 * b2 + a3 * b3 + c;
  end
endfunction



mac_wrapper_b #(.bw(bw), .psum_bw(psum_bw)) mac_wrapper_instance (
	.clk(clk), 
        .a0(a0), 
        .b0(b0),
        .a1(a1), 
        .b1(b1),
        .a2(a2), 
        .b2(b2),
        .a3(a3), 
        .b3(b3),
        .c(c),
	.out(out)
); 
 

initial begin 

  w_file = $fopen("b_data.txt", "r");  //weight data
  x_file = $fopen("a_data.txt", "r");  //activation

  $dumpfile("mac_tb_b.vcd");
  $dumpvars(0,mac_tb_b);
 
  #1 clk = 1'b0;  
  #1 clk = 1'b1;  
  #1 clk = 1'b0;

  $display("-------------------- Computation start --------------------");
  

  for (i=0; i<10; i=i+1) begin  // Data lenght is 10 in the data files

     #1 clk = 1'b1;
     #1 clk = 1'b0;

     w_scan_file = $fscanf(w_file, "%d\n", w0_dec);
     x_scan_file = $fscanf(x_file, "%d\n", x0_dec);

     w_scan_file = $fscanf(w_file, "%d\n", w1_dec);
     x_scan_file = $fscanf(x_file, "%d\n", x1_dec);

     w_scan_file = $fscanf(w_file, "%d\n", w2_dec);
     x_scan_file = $fscanf(x_file, "%d\n", x2_dec);

     w_scan_file = $fscanf(w_file, "%d\n", w3_dec);
     x_scan_file = $fscanf(x_file, "%d\n", x3_dec);

     a0 = x_bin(x0_dec); // unsigned number
     b0 = w_bin(w0_dec); // signed number
     a1 = x_bin(x1_dec); // unsigned number
     b1 = w_bin(w1_dec); // signed number
     a2 = x_bin(x2_dec); // unsigned number
     b2 = w_bin(w2_dec); // signed number
     a3 = x_bin(x3_dec); // unsigned number
     b3 = w_bin(w3_dec); // signed number
     c = expected_out;

     expected_out = mac_predicted(a0, b0, a1, b1, a2, b2, a3, b3, c);

  end



  #1 clk = 1'b1;
  #1 clk = 1'b0;

  $display("-------------------- Computation completed --------------------");

  #10 $finish;


end

endmodule




