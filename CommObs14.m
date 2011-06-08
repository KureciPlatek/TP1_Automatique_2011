clc; clear all; close all

%% 1.4 Commandabilite et observabilite
%% representation d'etat
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
  
%% Changement de base:
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

%% Commandabilite
% systeme 1 
SYS1 = ss(A,B,C,0);
CO_sys1 = ctrb(SYS1);
DET_sys1 = det(CO_sys1);
RG_sys1 = rank(CO_sys1)

% Le rang de la matrice est de 4, comme sa dimension, donc d'apres kalman
% le systeme sys1 est commandable.
% 

%Systeme chgmnt base:
SYS2 = ss(Ab,Bb,C*Pm1,0);
CO_sys2 = ctrb(SYS2);
DET_sys2 = det(CO_sys2);
RG_sys2 = rank(CO_sys2)

% Le rang de la matrice est de 4, comme sa dimension, donc d'apres kalman
% le systeme sys1 est completement commandable.

%% Observabilite cas a et cas b
% cas a)

SYS1_H1 = ss(A,B,C_H1,0);
SYS1_H2 = ss(A,B,C_H2,0);

% Calcul de la matrice [C CA] Kalman
OB_H1 = obsv(SYS1_H1);
OB_H2 = obsv(SYS1_H2);

% Comparaison entre le rang et la dimension
RG_sys2_H1 = rank(OB_H1)
RG_sys2_H2 = rank(OB_H2)

% Le critere d'observabilite sur teta n'est pas verifie. On ne peut donc
% pas observer teta
% Calcul des modes
[NUM_13, DEN_13] = ss2tf(A,B,C_H1,0);
Hs = tf(NUM_13, DEN_13);


% Observabilite dans la base Z

SYSZ_H1 = ss(Ab,Bb,C_H1*Pm1,0);
SYSZ_H2 = ss(Ab,Bb,C_H1*Pm1,0);

ObZ_H1 = obsv(SYSZ_H1);
ObZ_H2 = obsv(SYS1_H2);

RG_sysZ_H1 = rank(ObZ_H1)
% Teta n'est toujours pas observable en base Z
RG_sysZ_H2 = rank(ObZ_H2)
% Xi1 est toujours observable en base Z
% Donc quelque soit la base, on conserve les mêmes propriétés
% d'observation. Le changement de base n'est utile que pour changer la
% forme des matrices du systeme.






