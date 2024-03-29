/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module mojo_top_0 (
    input clk,
    input rst_n,
    output reg [7:0] led,
    output reg spi_miso,
    output reg [3:0] spi_channel,
    output reg avr_rx,
    output reg [23:0] io_led,
    output reg [7:0] io_seg,
    output reg [3:0] io_sel,
    input [23:0] io_dip,
    output reg a,
    output reg b,
    output reg c,
    input sum,
    input carry
  );
  
  
  
  reg rst;
  
  wire [1-1:0] M_reset_cond_out;
  reg [1-1:0] M_reset_cond_in;
  reset_conditioner_1 reset_cond (
    .clk(clk),
    .in(M_reset_cond_in),
    .out(M_reset_cond_out)
  );
  localparam MANUAL_state = 2'd0;
  localparam AUTO_state = 2'd1;
  localparam ERROR_state = 2'd2;
  
  reg [1:0] M_state_d, M_state_q = MANUAL_state;
  
  reg [28:0] M_counter_d, M_counter_q = 1'h0;
  
  integer z;
  
  always @* begin
    M_state_d = M_state_q;
    M_counter_d = M_counter_q;
    
    M_counter_d = M_counter_q + 1'h1;
    io_led = 24'h000000;
    io_seg = 8'hff;
    io_sel = 4'hf;
    z = 2'h0;
    a = 1'h0;
    b = 1'h0;
    c = 1'h0;
    M_reset_cond_in = ~rst_n;
    rst = M_reset_cond_out;
    led = 8'h00;
    spi_miso = 1'bz;
    spi_channel = 4'bzzzz;
    avr_rx = 1'bz;
    
    case (M_state_q)
      MANUAL_state: begin
        a = io_dip[0+0+0-:1];
        b = io_dip[0+1+0-:1];
        c = io_dip[0+2+0-:1];
        io_led[0+0+0-:1] = io_dip[0+0+0-:1];
        io_led[0+1+0-:1] = io_dip[0+1+0-:1];
        io_led[0+2+0-:1] = io_dip[0+2+0-:1];
        z = {carry, sum};
        if (io_dip[0+0+0-:1] + io_dip[0+1+0-:1] + io_dip[0+2+0-:1] == z) begin
          io_led[0+5+0-:1] = 1'h0;
        end else begin
          io_led[0+5+0-:1] = 1'h1;
        end
        if (io_dip[0+0+0-:1] + io_dip[0+1+0-:1] + io_dip[0+2+0-:1] != z) begin
          M_state_d = ERROR_state;
        end else begin
          if (io_dip[0+3+0-:1] == 1'h1) begin
            M_state_d = AUTO_state;
          end else begin
            M_state_d = MANUAL_state;
          end
        end
      end
      AUTO_state: begin
        a = M_counter_q[28+0-:1];
        b = M_counter_q[27+0-:1];
        c = M_counter_q[26+0-:1];
        io_led[0+0+0-:1] = M_counter_q[28+0-:1];
        io_led[0+1+0-:1] = M_counter_q[27+0-:1];
        io_led[0+2+0-:1] = M_counter_q[26+0-:1];
        z = {carry, sum};
        if (M_counter_q[28+0-:1] + M_counter_q[27+0-:1] + M_counter_q[26+0-:1] == z) begin
          io_led[0+5+0-:1] = 1'h0;
        end else begin
          io_led[0+5+0-:1] = 1'h1;
        end
        if (io_dip[0+0+0-:1] + io_dip[0+1+0-:1] + io_dip[0+2+0-:1] != z) begin
          M_state_d = ERROR_state;
        end else begin
          if (io_dip[0+3+0-:1] == 1'h1) begin
            M_state_d = AUTO_state;
          end else begin
            M_state_d = MANUAL_state;
          end
        end
      end
      ERROR_state: begin
        M_state_d = ERROR_state;
      end
    endcase
  end
  
  always @(posedge clk) begin
    M_state_q <= M_state_d;
  end
  
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_counter_q <= 1'h0;
    end else begin
      M_counter_q <= M_counter_d;
    end
  end
  
endmodule
