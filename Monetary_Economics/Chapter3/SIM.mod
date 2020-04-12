// run with nostrict option
var Y
    T
    YD
    C
    delta_H_s
    delta_H_h
    H;

varexo junk;

parameters G
           theta
           alpha_1
           alpha_2;

G = 20;
theta = 0.2;
alpha_1 = 0.6;
alpha_2 = 0.4;

model;
Y = C + G;
T = theta*Y;
YD = Y - T;
C = (alpha_1*YD) + (alpha_2*H(-1));
delta_H_s = G - T;
delta_H_h = YD - C;
H = delta_H_s + H(-1);
end;

histval;
H(0) = 0;
end;

steady(solve_algo=1,maxit=100);
check;
stoch_simul(irf=20,order=1) Y;
forecast(periods=100);
