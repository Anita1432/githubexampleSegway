clear all, close all, clc

mc = 3.2; %car mass
mp = 0.5; %pendulum mass
L = 0.6;  %length
d1 = 0.01;%q1 disp.
d2 = d1;  %q2 disp.
g = 9.78; %gravity
%%
%state space representation
A = [0 0 1 0;
    0 0 0 1;
    0 g*mp/mc -1*d1/mc -1*d2/(L*mc);
    0 g*(mc+mp)/(L*mc) -1*d1/(L*mc) -1*d2*(mc+mp)/(L^2*mc*mp) ];
B = [0; 0; 1/mc; 1/(L*mc)];

C = [1 0 0 0; 0 1 0 0; 0 0 1 0 ; 0 0 0 1]; %all posible outputs

D = zeros(size(C,1),size(B,2));
[num,den] = ss2tf(A,B,C,D);
sys = ss(A, B, C, D);
%step(sys)              %step response
%obs=obsv(sys);         %observability matrix
%cnt=ctrb(sys);         %controllability matrix
%rank(obs)              %obs matrix rank
%rank(cnt)              %cnt matrix rank
%pole(sys)              %system poles
%eig(sys)               %system eig (poles)
%rlocus(sys)            %poles and ceros 










