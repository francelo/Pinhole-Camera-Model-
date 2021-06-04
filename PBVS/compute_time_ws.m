function time = compute_time_ws(p, v)

syms x0 y0 T

xi = p(1);
yi = p(2);
vx = v(1);
vy = v(2);
vars = [x0 y0 T];
ws = 0.7;
time = 0;

eqns = [ws - sqrt(x0^2+y0^2) == 0, x0 - xi - vx*T == 0, y0 - yi - vy * T == 0];
sol = solve(eqns, vars);

if length(sol.T) > 1
    if sol.T(1) >= 0
        time = eval(sol.T(1));
    elseif sol.T(2) >= 0
        time = eval(sol.T(2));
    end
else
    time = eval(sol.T);
end

if length(time) < 1
    time = 1000;
end

        
end