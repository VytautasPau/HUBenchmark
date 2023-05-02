function [W, H] = demo( Y, Sw, Ws, M, lambda, tol, maxiter, timelimit)

% A L*M endmember matrix
% S row*col*M abundance maps
% Y row*col*L
% X L*N; N = row*col


[row,col,L] = size(Y);
% For real data, please normalize the radiance to a range of 0 - 1.0.
X = reshape(Y,row*col, L)';
% 3D HSI row*col*L

%% ********************* Pre-processing ********************** %%
% ## 1.SLIC image segmentation ****************************************** %
% Sw - the averange width of superpixels; {3-11} 
% P  - the number of superpixels;
% Ws - Trade-off coefficient between spatial and spectral distances;{0.5}

% Sw = 6; Ws = 0.5;
P = round(row*col/Sw^2); 
seg = slic_HSI(Y, P, Ws);

% ## 2.Initialize A and S *********************************************** %
% use region-based vca to initiate A_init
[A_VCA,~] = hyperVca(X,M);
[A_init,~] = hyperVca(seg.X_c,M);
% use FCLS to initiate S_init
S_init = fcls(A_init,X);

% show the parameters and initial matrices 
para = {};
para.tol = tol;   
para.maxiter = maxiter; % stop condition 1
para.timelimit = timelimit; % stop condition 2
para.verbose = 0;
para.print_iter = 100000000;
para.Y =Y; 
para.X = X; 
para.M = M; 
para.W =A_init; 
para.H =S_init;
para.lambda = lambda;  % 0.3

% W - estimated endmember martix;
% H - estimated abundance matrix;
[W, H] = sgsnmf(para,seg); 
