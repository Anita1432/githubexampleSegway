clear all, close all, clc

mc = 3.2; %car mass
mp = 0.5; %pendulum mass
L = 0.6;  %length
d1 = 0.01;%q1 disp.
d2 = d1;  %q2 disp.
g = 9.78; %gravity
A = [0 0 1 0;
    0 0 0 1;
    0 g*mp/mc -1*d1/mc -1*d2/(L*mc);
    0 g*(mc+mp)/(L*mc) -1*d1/(L*mc) -1*d2*(mc+mp)/(L^2*mc*mp) ];
B = [0; 0; 1/mc; 1/(L*mc)];

C = [1 0 0 0; 0 1 0 0]; %observable (necesary for LQG)

D = zeros(size(C,1),size(B,2));
[num,den] = ss2tf(A,B,C,D);
sys = ss(A, B, C, D);

Q = [1 0 0 0;
    0 1 0 0;
    0 0 20 0;
    0 0 0 100];
R = 0.01;

K = lqr(A,B,Q,R);


%  white noise perturbance
Vd = 0.001*eye(4);  
Vn = 0.001;        

BF = [B Vd 0*B];  % noisy input

sysC = ss(A,BF,C,[0 0 0 0 0 Vn]); 
%sysNC = ss(A,BF,eye(4),zeros(4,size(BF,2)));  

%%
%  Build Kalman filter
[l,P,E] = lqe(A,Vd,C,Vd,Vn); 
Kf = (lqr(A',C',Vd,Vn))';   % Kalman filter gain (simulink)
sysKF = ss(A-Kf*C,[B Kf],eye(4),0*[B Kf]);  % estimador del filtro de kalman
%Z=stepinfo(sysKF)

AA = (A - B*K);

%sacamos el sistema controlado con las matrices calculadas
sys_c = ss(AA, B, C, D);

%step(sysKF(1,2))


