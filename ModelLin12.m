clc; clear all; close all;

%% TP1 Pendule inverse

%% fonction de transfert:

% valeurs
M = 2;
m = 0.1;
l = 0.5;
g= 9.81;

% nump = [1];
% denp = [-M*l 0 g*(M+m)];
% H1p = tf([nump], [denp])
% sys1 = tf2ss(nump,denp)
%% representation d'etats
A = [0 0 1 0;0 0 0 1; 0 -(m/M)*g 0 0;0 (M+m)*g/(M*l) 0 0];
B = [0 0 1/M -1/(M*l);0 0 0 0;0 0 0 0;0 0 0 0];
C = [1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];

sys = ss(A,B,C,0);
x0 = [0;1;0;0];

figure(1)
initial(sys,x0)
grid on
legend('H1p')

% => systeme part en vrille, la fonction de transfert H1(p) est instable en
% boucle ouverte.

%% Correcteur:

k1 = - 24.525;
k2 = - 1;

K = [0 k1 0 k2];

%% Transfert en BF:
A1 = [0 0 1 0;0 0 0 1; 0 -(m/M)*g 0 0;0 (M+m)*g/(M*l) 0 0];
B1 = [0 0 1/M -1/(M*l)]';
C1 = [1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
x0 = [0;1;0;0];

%transformation en systeme
sys1 = ss((A1-B1*K),B1,C1,0);
figure(2)
initial(sys1,x0)
grid on
legend('Hbfp')

% %% Changement de base:
% 
% % matrice P
% P = [   0   0.11016 0   0.02427;
%         0   0.11016 0   -0.02427;
%         1   0.02381 0   0;
%         0   0       1   0.02381];
% % matrice C d'observation
% C_H1 = [0 1 0 0];
% C_H2 = [1 0 0 0];
%   
% Pm1 = inv(P)
% Ab = P*A1*Pm1
% Bb = P*B1
% x0 = [0;1;0;0];
% sys2 = ss(Ab,Bb,C_H1*Pm1,0)
% 
% % Comparaison des fonctions de transfert H1
% [NUM_H1_bar,DEN_H1_bar] = ss2tf(Ab,Bb,C_H1,0);
% [NUM_H1,DEN_H1] = ss2tf(A,B,C_H1,0);
% 
% H1_bar = tf(NUM_H1_bar,DEN_H1_bar)
% H1 = tf(NUM_H1,DEN_H1)
% 
% % Comparaison des fonctions de transfert H2
% 
% [NUM_H2_bar,DEN_H2_bar] = ss2tf(Ab,Bb,C_H2,0);
% [NUM_H2,DEN_H2] = ss2tf(A,B,C_H2,0);
% 
% H2_bar = tf(NUM_H2_bar,DEN_H2_bar)
% H2 = tf(NUM_H2,DEN_H2)


