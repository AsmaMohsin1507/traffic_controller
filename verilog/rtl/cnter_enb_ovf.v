module cnter_enb_ovf (// Inputs
 clk,
rst_n,
enable,
// Outputs
overflow ,
cnt_val
 );
parameter BITS = 32;
parameter MAX = 40000000 ;
//---- Port Declarations ----
input clk;
input rst_n;
input enable;
output overflow ;
output [BITS-1:0] cnt_val ;
//-- Intermediate sinal declarations
reg [BITS-1:0] cnt_val ;
reg overflow ;
always @(posedge clk or negedge rst_n)
begin
 if(~rst_n) begin
 cnt_val <= 0;
 overflow <= 1'b0;
 end
 else if(enable) begin
 if(cnt_val == MAX-1) begin
 cnt_val <= 0;
 overflow <= 1'b1;
 end
 else begin
 cnt_val <= cnt_val + 1;
 overflow <= 1'b0;
 end
 end
 else begin
 cnt_val <= cnt_val ;
 overflow <= 1'b0;
 end
end
endmodule
