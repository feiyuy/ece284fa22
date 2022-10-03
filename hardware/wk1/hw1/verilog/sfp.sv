// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module sfp
#(
    parameter   INPUT_WIDTH                     =   4,
    parameter   OUTPUT_WIDTH                    =   16
)
(
    input   logic                                   clk,
    input   logic                                   rst,

    input   logic   signed  [INPUT_WIDTH-1:0]       data_i,
    //threshold
    input   logic   signed  [OUTPUT_WIDTH-1:0]      thres_i,
    //accumulate operation
    input   logic                                   acc_i,
    //relu operation
    input   logic                                   relu_i,

    output  logic   signed  [OUTPUT_WIDTH-1:0]      data_o
);


    logic  signed   [OUTPUT_WIDTH-1:0]          data_q;
    assign  data_o                          =   data_q;

    always_ff @(posedge clk) begin
        if (rst) begin
            data_q                          <=  0;
        end
        else begin
            if (acc_i) begin
                data_q                      <=  data_q + data_i;
            end
            if (relu_i) begin
                if (data_q < thres_i) begin
                    data_q                  <=  0;
                end
            end
        end
    end

endmodule
