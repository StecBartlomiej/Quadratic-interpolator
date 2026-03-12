# Quadratic Interpolator

Function definition:
$$
f(x) = \sin(2x - \frac{\pi}{4})
$$

Polynomial interpolation:
$$
    f(x) \approx cx^2 + bx + a
$$

where $c$, $b$, $a$ are fixed point values with format $c_I$, $c_F$, $b_I$, 
$b_F$, $a_I$, $a_F$.

## Optimizing coefficient length

Optimized by running C++ model from Matlab using genetic algorithm. 

Task: 
$$
\min_x \pi(x)
$$

Input:
$$
    x = [c_I, c_F, b_I, b_F, a_I, a_F]
$$

Objective function with penalty function:
$$
    \pi(x) = \begin{cases}
    c_I + c_F + b_I + b_F + a_I + a_F & \text{simulation returns 0} \\
    10^3 & \text{simulation returns non-zero}
    \end{cases}
$$
