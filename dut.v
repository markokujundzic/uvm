module dut (
 input clk,
 input rst_n,
 input in,
 output out
);

localparam idle = 0;
localparam s1 = 1;
localparam s10 = 2;
localparam s101 = 3;
localparam s1011 = 4;

reg [2:0] state_next, state_reg;

assign out = state_reg == s1011 ? 1 : 0;

always @(posedge clk, negedge rst_n) begin
 if (!rst_n)
  state_reg <= idle;
 else
  state_reg <= state_next;
end

always @(*) begin
 state_next = state_reg;
 
 case (state_reg)

 idle: begin
  if (in)
   state_next = s1;
  else
   state_next = idle;
 end

 s1: begin
  if (in)
   state_next = s1;
  else
   state_next = s10;
 end

 s10: begin
  if (in)
   state_next = s101;
  else
   state_next = idle;
 end

 s101: begin
  if (in)
   state_next = s1011;
  else
   state_next = s10;
 end

 s1011: begin
  if (in)
   state_next = s1;
  else
   state_next = idle;
 end

 endcase

end

endmodule
