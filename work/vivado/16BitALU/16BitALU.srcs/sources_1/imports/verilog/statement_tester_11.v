/*
   This file was generated automatically by Alchitry Labs version 1.2.7.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

/*
   Parameters:
     TEST_ID_HIGH = 0
     TEST_ID_LOW = 4
     INPUT_X = 16h0000
     INPUT_Y = 16h0001
     OPCODE = 6b000001
     EXPECTED_OUTPUT = 16hFFFF
*/
module statement_tester_11 (
    input clk,
    input rst,
    input start,
    input error,
    output reg [7:0] io_seg,
    output reg [3:0] io_sel,
    output reg [5:0] opcode_led,
    output reg done
  );
  
  localparam TEST_ID_HIGH = 1'h0;
  localparam TEST_ID_LOW = 3'h4;
  localparam INPUT_X = 16'h0000;
  localparam INPUT_Y = 16'h0001;
  localparam OPCODE = 6'h01;
  localparam EXPECTED_OUTPUT = 16'hffff;
  
  
  reg [5:0] alufn;
  
  reg [15:0] x;
  
  reg [15:0] y;
  
  reg [3:0] id_high;
  
  reg [3:0] id_low;
  
  reg [15:0] q_signal;
  
  reg [15:0] fin_out;
  
  wire [1-1:0] M_slow_clk_edge_out;
  reg [1-1:0] M_slow_clk_edge_in;
  edge_detector_3 slow_clk_edge (
    .clk(clk),
    .in(M_slow_clk_edge_in),
    .out(M_slow_clk_edge_out)
  );
  wire [1-1:0] M_required_error_out;
  reg [1-1:0] M_required_error_in;
  button_conditioner_2 required_error (
    .clk(clk),
    .in(M_required_error_in),
    .out(M_required_error_out)
  );
  wire [1-1:0] M_error_edge_out;
  reg [1-1:0] M_error_edge_in;
  edge_detector_3 error_edge (
    .clk(clk),
    .in(M_error_edge_in),
    .out(M_error_edge_out)
  );
  localparam INIT_state = 4'd0;
  localparam DISP_X_1_state = 4'd1;
  localparam DISP_X_2_state = 4'd2;
  localparam DISP_Y_1_state = 4'd3;
  localparam DISP_Y_2_state = 4'd4;
  localparam DISP_OUT_1_state = 4'd5;
  localparam DISP_OUT_2_state = 4'd6;
  localparam DONE_state = 4'd7;
  localparam ERROR_1_state = 4'd8;
  localparam ERROR_2_state = 4'd9;
  
  reg [3:0] M_state_d, M_state_q = INIT_state;
  reg [15:0] M_out_d, M_out_q = 1'h0;
  wire [1-1:0] M_slow_clock_value;
  counter_26 slow_clock (
    .clk(clk),
    .rst(rst),
    .value(M_slow_clock_value)
  );
  wire [7-1:0] M_seg_display_seg;
  wire [4-1:0] M_seg_display_sel;
  reg [16-1:0] M_seg_display_values;
  multi_seven_seg_24 seg_display (
    .clk(clk),
    .rst(rst),
    .values(M_seg_display_values),
    .seg(M_seg_display_seg),
    .sel(M_seg_display_sel)
  );
  
  wire [16-1:0] M_alu_out;
  wire [1-1:0] M_alu_z;
  wire [1-1:0] M_alu_v;
  wire [1-1:0] M_alu_n;
  wire [1-1:0] M_alu_err;
  alu16_25 alu (
    .alufn(alufn),
    .x(x),
    .y(y),
    .out(M_alu_out),
    .z(M_alu_z),
    .v(M_alu_v),
    .n(M_alu_n),
    .err(M_alu_err)
  );
  
  reg compulsory_error;
  
  always @* begin
    M_state_d = M_state_q;
    M_out_d = M_out_q;
    
    M_required_error_in = error;
    M_error_edge_in = M_required_error_out;
    compulsory_error = M_error_edge_out;
    done = 1'h0;
    M_slow_clk_edge_in = M_slow_clock_value;
    io_seg = 8'hff;
    io_sel = 4'hf;
    M_seg_display_values = 16'h0000;
    alufn = 6'h01;
    x = 16'h0000;
    y = 16'h0001;
    id_high = 1'h0;
    id_low = 3'h4;
    M_out_d = M_alu_out;
    opcode_led = 6'h01;
    
    case (M_state_q)
      INIT_state: begin
        M_seg_display_values = {4'hc, 4'h5, id_high, id_low};
        io_seg = ~M_seg_display_seg;
        io_sel = ~M_seg_display_sel;
        if (start && M_slow_clk_edge_out) begin
          M_state_d = DISP_X_1_state;
        end
      end
      DISP_X_1_state: begin
        io_seg = 8'h89;
        io_sel = 4'he;
        if (M_slow_clk_edge_out) begin
          M_state_d = DISP_X_2_state;
        end
      end
      DISP_X_2_state: begin
        M_seg_display_values = {x[12+3-:4], x[8+3-:4], x[4+3-:4], x[0+3-:4]};
        io_seg = ~M_seg_display_seg;
        io_sel = ~M_seg_display_sel;
        if (M_slow_clk_edge_out) begin
          M_state_d = DISP_Y_1_state;
        end
      end
      DISP_Y_1_state: begin
        io_seg = 8'h91;
        io_sel = 4'he;
        if (M_slow_clk_edge_out) begin
          M_state_d = DISP_Y_2_state;
        end
      end
      DISP_Y_2_state: begin
        M_seg_display_values = {y[12+3-:4], y[8+3-:4], y[4+3-:4], y[0+3-:4]};
        io_seg = ~M_seg_display_seg;
        io_sel = ~M_seg_display_sel;
        if (M_slow_clk_edge_out) begin
          M_state_d = DISP_OUT_1_state;
        end
      end
      DISP_OUT_1_state: begin
        io_seg = 8'ha3;
        io_sel = 4'he;
        if (M_slow_clk_edge_out) begin
          M_state_d = DISP_OUT_2_state;
        end
      end
      DISP_OUT_2_state: begin
        M_seg_display_values = {M_out_q[12+3-:4], M_out_q[8+3-:4], M_out_q[4+3-:4], M_out_q[0+3-:4]};
        io_seg = ~M_seg_display_seg;
        io_sel = ~M_seg_display_sel;
        q_signal = ~M_out_q;
        fin_out = M_out_q;
        if (compulsory_error) begin
          fin_out = q_signal;
        end
        if (M_slow_clk_edge_out && fin_out == 16'hffff) begin
          M_state_d = DONE_state;
        end else begin
          if (M_slow_clk_edge_out && fin_out != 16'hffff) begin
            M_state_d = ERROR_1_state;
          end
        end
      end
      DONE_state: begin
        io_seg = 8'ha1;
        io_sel = 4'he;
        opcode_led = 6'h00;
        done = 1'h1;
      end
      ERROR_1_state: begin
        M_seg_display_values = 16'heeee;
        io_seg = ~M_seg_display_seg;
        io_sel = ~M_seg_display_sel;
      end
    endcase
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_out_q <= 1'h0;
      M_state_q <= 1'h0;
    end else begin
      M_out_q <= M_out_d;
      M_state_q <= M_state_d;
    end
  end
  
endmodule
