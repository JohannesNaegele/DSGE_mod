// run with nostrict option
var //G
    Y
    T
    YD
    YD_e
    C
    B_h
    B_s
    B_cb
    H_h
    H_s
    V
    V_e
    r;

varexo junk;

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
Y = C + G;
T = theta*(Y+r(-1)*B_h(-1));
YD = Y - T + r(-1)*B_h(-1);
YD_e = YD(-1);
C = (alpha_1*YD_e) + (alpha_2*V(-1));
B_h = V_e*(lambda_0 + lambda_1*r - lambda_2*(YD_e/V));
H_h = V_e - B_h;
B_s = B_s(-1) + (G + r(-1)*B_s(-1)) - (T - r(-1)*B_cb(-1));
B_cb = B_s - B_h;
H_s = H_s(-1) + B_cb - B_cb(-1);
V = V(-1) + (YD - C);
V_e = V(-1) + (YD_e - C);
r = r(-1);
// Nicht machen: Sonst wird ein steady state von 0 berechnet
// G = G(-1);
end;

initval;
Y = 110.;
T = 23;
YD = 90;
YD_e = 1.;
C = 90.;
B_h = V_e*(lambda_0 + lambda_1*r - lambda_2*(YD_e/V));
H_h = V_e*(1-B_h/V_e);
B_h = 72;
H_h = 1.;
B_s = 1.;
B_cb = 1.;
H_s = 1.;
V = 90;
V_e = 1.;
r = 1.;
end;

histval;
// G(0) = 20;
// Y(0) = 106;
// T(0) = 22;
YD(0) = 86;
B_h(0) = 65;
// C(0) = 86;
V(0) = 86;
r(0) = 0.025;
end;

steady;
check;
stoch_simul(irf=20,order=1) Y;
forecast(periods=100);
