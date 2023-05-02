function [W, H]=demo(V, r, maxiter, tol, trackit, lambda, mu, lambda_TV)
%% TV-reweighted sparse algorithm demo

%% simu bicus
%load signatures
%load BANDS
c = r;
[M,N,D] = size(V);
mixed = reshape(V,M*N,D)';

%% Ainit, sinit can be empty
% remove noise
% [UU, SS, VV] = svds(mixed,c);
% Lowmixed = UU'*mixed;
% mixed = UU*Lowmixed;
% EM = UU'*A;

% SID select
% [ A_vca ] = SID_select( mixed, c, 0.6);
% A_vca = rand(D,c);
% vca algorithm
% [A_vca, EndIdx] = VCA(mixed,'Endmembers', c,'SNR', SNR,'verbose','on');
% load A_SID
% load A_vca4.mat
% FCLS
% warning off;

%AA = [1e-5*A_vca;ones(1,length(A_vca(1,:)))];
%s_fcls = zeros(length(A_vca(1,:)),M*N);
%for j=1:M*N
%    r = [1e-5*mixed(:,j); 1];
%    s_fcls(:,j) = nnls(AA,r);
%end
%  use vca to initiate
%Ainit = A_vca;
%sinit = s_fcls;

%% Ainit, sinit can be empty

%% total variation regularized spase NMF
%lamndaval = [0.0005,0.001,0.005,0.01,0.05,0.1,0.2,0.3];
%muvalue = [1e1,1e2,1e3];
%lambda_TVval = [1e-4,1e-3,1e-2,1e-1];
%result = zeros(3,length(lamndaval),length(muvalue),length(lambda_TVval));
%for ii=1:length(lamndaval)
%    lambda = lamndaval(ii);
%    for jj=1:length(muvalue)
%        mu = muvalue(jj);
%        for zz = 1:length(lambda_TVval)
%            lambda_TV = lambda_TVval(zz);
% opt_mult = struct('maxiter',1000,'tol',1e-6,'trackit',20,'w',Ainit,'h',sinit,'lambda',0.01,'mu',1e2,'lambda_TV',2e-2,'image_size',[M,N]);
% opt_mult = struct('maxiter', maxiter,'tol', tol,'trackit', trackit,'w', [],'h', [],'lambda', lambda,'mu', mu, 'lambda_TV', lambda_TV, 'image_size', [M,N]);
[W H]=TV_WSNMF(mixed,c, double(maxiter), double(tol), double(trackit), [], [], double(lambda), double(mu), double(lambda_TV), [M,N]);
