%%
clc
clear
close all

%% Parametros
M = 0.7; % masa del carro
m = 0.027; % masa del pendulo
g = 9.81; % gravedad
L = 0.145; % longitud del pendulo
k = 0.1; % friccion del carro
I = 0.006;%(M*L^2)/3; % friccion en la union
radio = 42/(2*1000);

%% Sistema
% todas las unidades de salida estan en radianes 
p = I*(M+m)+M*m*L^2;
A = [0      1              0           0;
     0 -(I+m*L^2)*k/p  (m^2*g*L^2)/p   0;
     0      0              0           1;
     0 -(m*L*k)/p       m*g*L*(M+m)/p  0];
B = [     0;
     (I+m*L^2)/p;
          0;
        m*L/p];
C = [0 0 1 0; 0 0 0 1; 1 0 0 0; 0 1 0 0];

D = zeros(4,1);



x0 = [0; 0; 0.2; 0]; % empieza quieto y girado 5 grados

%% LQR
Q = [ 50   0   0  0;
       0   1   0  0;
       0   0 500  0;
       0   0   0  1];
R = 1;
K = lqr(A,B,Q,R);
K = K*C
%K = -[50 18 5 5];

%% PID
%PID = [0.4 14 0.005];
PID = [1 1 1];