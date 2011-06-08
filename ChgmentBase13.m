clc; clear all; close all;

%%  representation d'etat
% valeurs
M = 2;
m = 0.1;
l = 0.5;
g= 9.81;
% matrices
A = [0 0 1 0;
      0 0 0 1; 
      0 -(m/M)*g 0 0;
      0 (M+m)*g/(M*l) 0 0];
B = [0 0 1/M -1/(M*l)]';
C = [1 0 0 0;
      0 1 0 0;
      0 0 1 0;
      0 0 0 1];

%% 13 Changement de base:
x12 = (1/2)*sqrt((M*l/((M+m)*g)));
x14 = (1/2)*(M*l)/((M+m)*g);
x22 = (1/2)*sqrt((M*l/((M+m)*g)));
x24 = -(1/2)*(M*l)/((M+m)*g);
x32 = m*l/(M+m);
x44 = m*l/(M+m);

% matrice P
P = [   0   x12 0 x14;
        0   x22 0 x24;
        1   x32 0 0  ;
        0   0   1 x44];
    
% matrice C d'observation
C_H1 = [0 1 0 0];
C_H2 = [1 0 0 0];
  
Pm1 = inv(P);
Ab = P*A*Pm1;
Bb = P*B;
x0 = [0;1;0;0];
sys2 = ss(Ab,Bb,C_H1*Pm1,0);

% Comparaison des fonctions de transfert H1
[NUM_H1_bar,DEN_H1_bar] = ss2tf(Ab,Bb,C_H1*Pm1,0);
[NUM_H1,DEN_H1] = ss2tf(A,B,C_H1,0);

H1_bar = tf(NUM_H1_bar,DEN_H1_bar)
H1 = tf(NUM_H1,DEN_H1)

% Comparaison des fonctions de transfert H2
[NUM_H2_bar,DEN_H2_bar] = ss2tf(Ab,Bb,C_H2*Pm1,0);
[NUM_H2,DEN_H2] = ss2tf(A,B,C_H2,0);

H2_bar = tf(NUM_H2_bar,DEN_H2_bar)
H2 = tf(NUM_H2,DEN_H2)

% On observe les resultats suivants
% fonctions de transfert H1
% Transfer function:
%     -s^2
% --------------
% s^4 - 20.6 s^2
%  
%  
% Transfer function:
%     8.882e-016 s^3 - s^2
% -------------------------------
% s^4 - 8.882e-016 s^3 - 20.6 s^2
%  
% fonctions de transfert H2 
% Transfer function:
% 6.217e-015 s^3 + 0.5 s^2 + 1.288e-014 s - 9.81
% ----------------------------------------------
%                s^4 - 20.6 s^2
%  
%  
% Transfer function:
% 1.193e-015 s^3 + 0.5 s^2 + 1.242e-014 s - 9.81
% ----------------------------------------------
%       s^4 - 8.882e-016 s^3 - 20.6 s^2
       
% On observe bien une ressemblance entre les différentes fonctions de transfert. 
% les coefficients en cube sont très petits, ils sont normalement
% inexistants. Cela est du à une erreur d'arrondi. bien la bonne
% bizounette
 