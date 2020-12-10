clear all, close all, clc

mc = 3.2; %car mass
mp = 0.5; %pendulum mass
L = 0.6;  %length
d1 = 0.01;%q1 disp.
d2 = d1;  %q2 disp.
g = 9.78; %gravity
%%
%state space system
A = [0 0 1 0;
    0 0 0 1;
    0 g*mp/mc -1*d1/mc -1*d2/(L*mc);
    0 g*(mc+mp)/(L*mc) -1*d1/(L*mc) -1*d2*(mc+mp)/(L^2*mc*mp) ];
B = [0; 0; 1/mc; 1/(L*mc)];
C = [1 0 0 0];
D = zeros(size(C,1),size(B,2));
sys = ss(A, B, C, D);
valores = eig(sys);

%Desire poles for an stable system
P = [-3; -3; -3; -3]*1.5;
KPP = acker(A,B,P); %K gain for close loop

%stable system
AA = A-B*KPP;
sysC = ss(AA,B,C,D);
new_values = eig(sysC);
%step(sysC)

%Solve for compensation gain
Kr = 1/-(C*inv(A-B*KPP)*B)
sysCC = ss(AA,B*Kr,C,D);

opt = stepDataOptions('InputOffset',0,'StepAmplitude',1.5);
step(sysCC,opt)


