clc; clear all; close all;

%% 1.5 Proprietes de stabilite:


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
  
%% Stabilite avec la fonction eig:
Stab = eig(A)
% Stab =
%         0
%         0
%    4.5388
%   -4.5388

% On regarde la matrice A, afin de connaitre la stabilite de la matrice de
% transfert. On obtiens deux val. propres nulles, une négative, et une
% positive. Le système est donc instable.

% On va calculer le correcteur afin de rendre le systeme stable. Pour cela,
% on va utiliser la fonction acker(), cette fonction permet de calculer un
% vecteur K, pour atteindre une fonction stable, en fonction des matrices A
% et B.

% On cherche a obtenir le polynome suivant: 
P = [-1 -1 -1 -1];
% Il est de dimension 4, car il doit etre de la meme dimension que la
% matrice A. Et ses valeurs sont des -1 car on desire obtenir des poles
% negatifs.

K = acker(A,B,P)
% K =   -0.1019  -26.6520   -0.4077   -4.2039

StabK = eig(A-B*K)
% On obtient biend es poles a partie entiere negative:
%StabK =

%  -1.0002 + 0.0002i
%  -1.0002 - 0.0002i
%  -0.9998 + 0.0002i
%  -0.9998 - 0.0002i

x0 = [1;1;1;1]

SYS = ss((A-B*K),B,C,0);
figure(1)
initial(SYS,x0)
grid on
legend('Hcorrige_p')
title('Réponse du système bouclé')

% On observe bien que les reponses sur tout les axes sont stabilisees.
% Tendent vers une valeur finale.

%% tracage du transfert de boucle:
% Calcul de (pI-A)^(-1).


% pI = [s 0 0 0;
%       0 s 0 0;
%       0 0 s 0;
%       0 0 0 s];
% 
% PimA = inv(pI-A)

