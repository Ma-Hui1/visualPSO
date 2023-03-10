% The program displays the detail of PSO
% 
% @author Tylor Jaden(bilibiliUID:38263507)
% @version 1.0
% @since   2022-10-27
close all;
clear;
clc;
tic;
syms x1 x2;
f =x1 .^ 2 - x2 .^ 2;
% f = 5 * x1 .^ 2 + 8 * x2 ^3;
x1 = -10:1:10;
x2 = -10:1:10;
g=matlabFunction(f);
[A,B] = PSO(f,-10,10);
disp([A,B]);
disp(g(A,B));
toc;