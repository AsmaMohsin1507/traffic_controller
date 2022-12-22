module traffic_sm (// Inputs
 clk,
rst_n,
enable,
 counter_24 ,
 // Outputs
enable_sig ,
road1_out ,
road2_out
 );
// Inputs
input clk ;
input rst_n ;
input enable ;
input [4:0] counter_24 ;
// Outputs
output enable_sig ;
output [2:0] road1_out ;
output [2:0] road2_out ;
parameter [6:0] IDLE = 7'b0000001 ,
 Y1_R1_S1 = 7'b0000010 ,
 G1_R2_S2 = 7'b0000100 ,
 Y1_R2_S3 = 7'b0001000 ,
 R1_Y2_S4 = 7'b0010000 ,
 R1_G2_S5 = 7'b0100000 ,
 R1_Y2_S6 = 7'b1000000 ;
parameter [2:0] RED = 3'b001 ,
 YELLOW = 3'b010 ,
 GREEN = 3'b100 ;
reg [6:0] traffic_state ;
reg enable_sig ;
reg [2:0] road1_out ;
reg [2:0] road2_out ;
// State Register & Next State Logic
always @(posedge clk or negedge rst_n)
begin
 if(~rst_n) begin
 traffic_state <= IDLE ;
 end
 else begin
 case(traffic_state )
 IDLE : begin
 if(enable)
 traffic_state <= Y1_R1_S1 ;
 else
 traffic_state <= IDLE ;
 end
 Y1_R1_S1 : begin
 if(counter_24 == 5'd1)
 traffic_state <= G1_R2_S2 ;
 else
 traffic_state <= Y1_R1_S1 ;
 end
 G1_R2_S2 : begin
 if(counter_24 == 5'd11)
 traffic_state <= Y1_R2_S3 ;
 else
 traffic_state <= G1_R2_S2 ;
 end
 Y1_R2_S3 : begin
 if(counter_24 == 5'd13)
 traffic_state <= R1_Y2_S4 ;
 else
 traffic_state <= Y1_R2_S3 ;
 end
 R1_Y2_S4 : begin
 if(counter_24 == 5'd15)
 traffic_state <= R1_G2_S5 ;
 else
 traffic_state <= R1_Y2_S4 ;
 end
 R1_G2_S5 : begin
 if(counter_24 == 5'd25)
 traffic_state <= R1_Y2_S6 ;
 else
 traffic_state <= R1_G2_S5 ;
 end
 R1_Y2_S6 : begin
 if(counter_24 == 5'd27)
 traffic_state <= IDLE ;
 else
 traffic_state <= R1_Y2_S6 ;
 end
 default : begin
 traffic_state <= IDLE ;
 end
 endcase
 end
end
// Output Logic
always @(traffic_state )
begin
 case(traffic_state )
 IDLE : begin
 enable_sig = 1'b0 ;
 road1_out = RED ;
road2_out = RED ;
 end
 Y1_R1_S1 : begin
 enable_sig = 1'b1 ;
 road1_out = YELLOW ;
road2_out = RED ;
 end
 G1_R2_S2 : begin
 enable_sig = 1'b1 ;
 road1_out = GREEN ;
road2_out = RED ;
 end
 Y1_R2_S3 : begin
 enable_sig = 1'b1 ;
 road1_out = YELLOW ;
road2_out = RED ;
 end
 R1_Y2_S4 : begin
 enable_sig = 1'b1 ;
 road1_out = RED ;
road2_out = YELLOW ;
 end
 R1_G2_S5 : begin
 enable_sig = 1'b1 ;
 road1_out = RED ;
road2_out = GREEN ;
 end
 R1_Y2_S6 : begin
 enable_sig = 1'b1 ;
 road1_out = RED ;
road2_out = YELLOW ;
 end
 default : begin
 enable_sig = 1'b0 ;
 road1_out = RED ;
road2_out = RED ;
 end
 endcase
end
endmodule
