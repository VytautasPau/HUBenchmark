function [A_est, S_est, B_est, E_est, A_truth_patch, EM_est, AB_map] = demo(Y3d, endM, E_init, param, maxiter, flag, A_true)

clc;
clear;
close all;

%% add the path
addpath('synthetic_data'); 
addpath('functions'); 

load synthetic_data.mat; %load the synthetic data
load Extracted_EM.mat; %load endmembers extracted from HSI using VCA

%M : real endmembers (l by p)
%A_true : real abundance maps (m*n by p)
%X : input spectral signatures (m*n by l)
%m and n : length and width of the HSI
%L : the number of bands
%p : the number of endmembers

Y = X'; %HSI_2d
Y3d = hyperConvert3d(Y,m,n,L); %HSI_3d
A_true = A_true'; %ground truth for abundances

%% initializing the spectral variability dictionary
E_random = orth(randn(L,1000));
num = 100; %the number of atoms in the spectral variability dictionary
E_init = E_random(:,1:num);

if ~exist('endmembers','var')
    
    num_endmembers = 5; %the number of endmembers
    endmembers = VCA(Y, 'Endmembers', num_endmembers, 'SNR', 30);
    s = 1 - pdist2(endmembers', M', 'cosine');
    [mi, ind] = sort(s, 'descend');
    index = ind(1, :);
else    
    
    s = 1-pdist2(endmembers', M', 'cosine');
    [mi, ind] = sort(s, 'descend');
    index = ind(1, :);
end

%% parameter setting in ALMM
param.alfa = 2e-3;
param.beta = 2e-3;
param.gama = 5e-3;
param.eta  = 5e-3;
param.mk   = 10; % the length or width of the patch (square)
maxiter = 100;

%% run ALMM to unmix HSI

[A_est, S_est, B_est, E_est, A_truth_patch, EM_est, AB_map] = ALMM(Y3d, endmembers, E_init, param, maxiter, 'Blind', A_true);



