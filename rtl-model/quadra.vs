//
// Quadratic polynomial:  f(x) = a + b*x2 + c*(x2^2)
//

`include "quadra.vh"

module quadra
( // <challenge>
	input ck_t clk,
	input  x_t x,
	output y_t y
);
// <challenge>    

// connections 
a_t a; // s4.28
b_t b; // s4.28
c_t c; // s4.28
sq_t x2_sq; // u0.34

lut lut_inst(
	.x1(stage1_x1),
	.a(a),
	.b(b),
	.c(c)
	);

square square_inst(
	.x2(stage1_x2),
	.sq(x2_sq)
	);

// stage 1
x1_t stage1_x1; // u1.5
x2_t stage1_x2; // u0.17

always_ff @(posedge clk)
begin
	stage1_x1 <= x[X_W-1:X2_W];
	stage1_x2 <= x[X2_W-1:0];
end


// stage 2
a_t stage2_a; // s4.28
b_t stage2_b; // s4.28
c_t stage2_c; // s4.28
x2_t stage2_x2; // u0.17
sq_t stage2_x2_sq; // u0.34

always_ff @(posedge clk)
begin
	stage2_a <= a;
	stage2_b <= b;
	stage2_c <= c;
	stage2_x2 <= stage1_x2;
	stage2_x2_sq <= x2_sq;
end

// stage 3
logic signed [C_W+SQ_W-1:0] full_t2_product;
logic signed [B_W+X2_W-1:0] full_t1_product;

t0_t stage3_t0; // s4.27
t1_t stage3_t1; // s4.27
t2_t stage3_t2; // s4.27

s_t s; // s2.27


always_ff @(posedge clk)
begin
	stage3_t0 <= stage2_a >>> (A_F - T0_F);
	stage3_t1 <= (full_t1_product) >>> (B_F + X2_F - T1_F);
	stage3_t2 <= (full_t2_product) >>> (C_F + SQ_F - T2_F);
end

assign full_t1_product = stage2_b * stage2_x2;
assign full_t2_product = stage2_c * stage2_x2_sq;
assign s = stage3_t0 + stage3_t1 + stage3_t2;
assign y = s >>> (R_F);

endmodule
