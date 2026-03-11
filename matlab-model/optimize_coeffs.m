
% x = [C_I, C_F, B_I, B_F, A_I, A_F];
coeffs_0 = [4, 28, 4, 28, 4, 28]';
sum_length(coeffs_0)

% Genetic algorithm
fx = @sum_length;
nvars = 6;
A = [];
b = [];
Aeq = [];
beq = [];
lb = [1; 10; 1; 10; 1; 10]; % lb <= coeffs
ub = [4; 30; 4; 30; 4; 30]; % coeffs <= ub
nonlcon = [];
intcon = 1:nvars; % every value is integer

options = optimoptions('ga', 'MaxGenerations', 20, 'Display', 'iter', 'PlotFcn', @gaplotbestf);

opt_coeffs = ga(...
	fx, nvars, A, b, Aeq, beq, lb, ub, nonlcon, intcon, options ...
	)

save("best_coeff", "opt_coeffs");


function y = sum_length(coeffs)
C_I = coeffs(1);
C_F = coeffs(2);
B_I = coeffs(3);
B_F = coeffs(4);
A_I = coeffs(5);
A_F = coeffs(6);

% build and run c++ simulation from matlab
path = "cd ../c++-model/ && export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH && ";
build_cmd = sprintf(...
	"make CXXFLAGS='-DDBG_OPT -DC_I=%d -DC_F=%d -DB_I=%d -DB_F=%d -DA_I=%d -DA_F=%d' DBG_TST=0 clean all run &> /dev/null; echo $?", ...
	C_I, C_F, B_I, B_F, A_I, A_F...
	);

cmd = path + build_cmd;
[~, out] = system(cmd);
value = str2double(out);

if (value ~= 0)
	y = 1e3;
else
	y = sum(coeffs);
end

end % function sum_length

