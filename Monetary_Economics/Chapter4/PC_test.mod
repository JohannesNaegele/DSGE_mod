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
    ;

varexo junk;

parameters theta
           alpha_1
           alpha_2
           lambda_0
           lambda_1
           lambda_2
           G
           r
           ;
theta = 0.2;
alpha_1 = 0.6;
alpha_2 = 0.4;
lambda_0 = 0.635;
lambda_1 = 5;
lambda_2 = 0.01;
G = 20;
r = 0.025;

model;
Y = C + G;//
T = theta*(Y + r*B_h(-1));//
YD = Y - T + r*B_h(-1);//
//YD_e = YD(-1);
C = (alpha_1*YD) + (alpha_2*V(-1));//
B_h = V*(lambda_0 + lambda_1*r - lambda_2*(YD/V));//
H_h = V - B_h;//
B_s = B_s(-1) + (G + r*B_s(-1)) - (T + r*B_cb(-1));//
B_cb = B_s - B_h;//
H_s = H_s(-1) + B_cb - B_cb(-1);//
V = V(-1) + (YD - C);//
//V_e = V(-1) + (YD_e - C);
// Nicht machen: Sonst wird ein steady state von 0 berechnet
// G = G(-1);
end;

initval;
V = 1.;
end;

histval;
V(0) = 1.;
end;

steady(maxit=10);
check;
stoch_simul(irf=20,order=1) Y;
forecast(periods=100);

//perfect_foresight_setup(periods=200);
//perfect_foresight_solver(maxit=100);
