clear all, close all, clc

mc = 3.2; %car mass
mp = 0.5; %pendulum mass
L = 0.6;  %length
d1 = 0.01;%q1 disp.
d2 = d1;  %q2 disp.
g = 9.78; %gravity

A = [0 0 1 0;
    0 0 0 1;
    0 g*mp/mc -d1/mc -d2/(L*mc);
    0 g*(mc+mp)/(L*mc) -d1/(L*mc) -d2*(mc+mp)/(L^2*mc*mp) ];
B = [0; 0; 1/mc; 1/(L*mc)];
D=[0];
C1 = [1 0 0 0];
C2 = [0 1 0 0];
[num1,den1]=ss2tf(A,B,C1,D); % depending on the displacement as an output
[num2,den2]=ss2tf(A,B,C2,D); %depending on the angle as an output
%step(tf(num1,den1);
%step(tf(num2,den2);
 