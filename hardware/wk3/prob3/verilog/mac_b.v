// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module mac_b
#(
    parameter       DATA_WIDTH                          =   4,
    parameter       SUM_WIDTH                           =   16
)
(
    input   wire            [DATA_WIDTH-1:0]                data0_in,
    input   wire    signed  [DATA_WIDTH-1:0]                weight0_in,
    input   wire            [DATA_WIDTH-1:0]                data1_in,
    input   wire    signed  [DATA_WIDTH-1:0]                weight1_in,
    input   wire            [DATA_WIDTH-1:0]                data2_in,
    input   wire    signed  [DATA_WIDTH-1:0]                weight2_in,
    input   wire            [DATA_WIDTH-1:0]                data3_in,
    input   wire    signed  [DATA_WIDTH-1:0]                weight3_in,
    input   wire    signed  [SUM_WIDTH-1:0]                 acc_in,

    output  wire    signed  [SUM_WIDTH-1:0]                 acc_out

);

    assign  acc_out =   acc_in + data0_in * weight0_in + data1_in * weight1_in + data2_in * weight2_in + data3_in * weight3_in;

endmodule
