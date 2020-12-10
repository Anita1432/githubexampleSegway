clear all
close all
clc

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

C = [1 1 0 0]; 

D = zeros(size(C,1),size(B,2));
[num,den] = ss2tf(A,B,C,D);
sys = ss(A, B, C, D);
 %%
 %LQR design
Q = [100 0 0 0;
    0 100 0 0;
    0 0 100 0;
    0 0 0 100];
R = 0.1;

K = lqr(A,B,Q,R);
n = length(K);
AA = A - B * K;
for i=1:n
    BB(:,i)=B * K(i);
end
CC=C;
DD=D;
for i=1:n
     sys(:,i)=ss(AA,BB(:,i),CC,DD);
end

sysC = ss(AA,B,C,D);
sysCC = series(1,sys_ctr);
%step(sys_final);
%Z = stepinfo(sys_final);

