// run with nostrict option
var //G
    Y
    T
    YD
    //YD_e
    C
    B_h
    B_s
    B_cb
    H_h
    H_s
    V
    //V_e
    r
    ;

varexo junk test;

parameters theta
           alpha_1
           alpha_2
           lambda_0
           lambda_1
           lambda_2
           G;
theta = 0.2;
alpha_1 = 0.6;
alpha_2 = 0.4;
lambda_0 = 0.635;
lambda_1 = 5;
lambda_2 = 0.01;
G = 20;

model;
Y = C + G;//
T = theta*(Y + r(-1)*B_h(-1));//
YD = Y - T + r(-1)*B_h(-1);//
//YD_e = YD(-1);
C = ((alpha_1 + test)*YD) + (alpha_2*V(-1));//
B_h = V*(lambda_0 + lambda_1*r - lambda_2*(YD/V));//
H_h = V - B_h;//
B_s = B_s(-1) + (G + r(-1)*B_s(-1)) - (T + r(-1)*B_cb(-1));//
B_cb = B_s - B_h;//
H_s = H_s(-1) + B_cb - B_cb(-1);//
V = V(-1) + (YD - C);//
//V_e = V(-1) + (YD_e - C);
// Nicht machen: Sonst wird ein steady state von 0 berechnet
// G = G(-1);
r = r(-1);
end;

shocks;
var test; stderr 0;
end;

initval;
Y = 106.;
T = 21.26;
YD = 86.49;
//YD_e = YD(-1);
C = 86.49;
B_h = 64.86;
H_h = 21.62;
B_s = 86.49;
B_cb = 21.62;
H_s = 21.62;
V = 86.49;
r = 0.025;
end;

// initval;
// Y = 100.;
// T = 100.;
// YD = 100.;
// C = 100.;
// B_h = 100.;
// H_h = 100.;
// B_s = 100.;
// B_cb = 100.;
// H_s = 100.;
// V = 100.;
// r = 100.;
// end;

histval;
V(0) = 1.;
r(0) = 0.025;
end;

steady(solve_algo=0,maxit=100);
check;
stoch_simul(irf=20,order=1) Y;
forecast(periods=100);

perfect_foresight_setup(periods=200);
perfect_foresight_solver(maxit=100);
