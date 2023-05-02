%% TV-reweighted sparse algorithm demo

clear all;
addpath './code'
addpath 'simulated data'
%% simu bicus
load signatures
load BANDS
c = 4;
A = A(BANDS,[1:c]); 
% A = A(:,[1:c]);
load abf;
mixed = A*abf;mixed = mixed';
mixed = reshape(mixed,48,48,188);
[M,N,D] = size(mixed);
mixed = reshape(mixed,M*N,D);

SNR = 20; %dB
variance = sum(mixed(:).^2)/10^(SNR/10)/M/N/D;
n = sqrt(variance)*randn([D M*N]);

mixed = mixed' + n;
YY = max(mixed,0);
clear n;

%% initilization
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
load A_SID
% load A_vca4.mat
% FCLS
% warning off;
AA = [1e-5*A_vca;ones(1,length(A_vca(1,:)))];
s_fcls = zeros(length(A_vca(1,:)),M*N);
for j=1:M*N
    r = [1e-5*mixed(:,j); 1];
    s_fcls(:,j) = nnls(AA,r);
end
%  use vca to initiate
Ainit = A_vca;
sinit = s_fcls;
showflag = 0;

%% VCA result
% Aest = Ainit;
% sest = sinit;

%% test via ASSNMF
%     delta = 2e1;
%     RA = [YY;delta*ones(1,M*N)];
%     MA = [Ainit; delta*ones(1,c)];
%     %参数
%     sinit = max(sinit,0.001);
%     sinit = min(sinit,1);%去除大于1的值
%     threshold = 0.01; %总体阈值
%     thresholdAbund = 0.01; %丰度约束条件的阈值
%     maxiter = 100; %总体最大迭代次数
%     row=M;
%     col=N;
%     u1= 0.28*M*N+1000;
% %      u2 =0 %5/P;
%     u2 =5/12;
%     [Aest,sest,obj] = ASSNMF(YY,Ainit,sinit,RA,MA,threshold,thresholdAbund,maxiter,row,col,u1,u2);%估计端元和丰度
%% use L_1/2_NMF
% opt_mult = struct('maxiter',2000,'tol',1e-4,'trackit',20,'w',Ainit,'h',sinit,'Vtrue',[]);
% [Aest sest]=Lee_SNMF(YY,c,opt_mult);
%% total variation regularized spase NMF
lamndaval = [0.0005,0.001,0.005,0.01,0.05,0.1,0.2,0.3];
muvalue = [1e1,1e2,1e3];
lambda_TVval = [1e-4,1e-3,1e-2,1e-1];
result = zeros(3,length(lamndaval),length(muvalue),length(lambda_TVval));
for ii=1:length(lamndaval)
    lambda = lamndaval(ii);
    for jj=1:length(muvalue)
        mu = muvalue(jj);
        for zz = 1:length(lambda_TVval)
            lambda_TV = lambda_TVval(zz);
% opt_mult = struct('maxiter',1000,'tol',1e-6,'trackit',20,'w',Ainit,'h',sinit,'lambda',0.01,'mu',1e2,'lambda_TV',2e-2,'image_size',[M,N]);
opt_mult = struct('maxiter',1000,'tol',1e-6,'trackit',20,'w',Ainit,'h',sinit,'lambda',lambda,'mu',mu,'lambda_TV',lambda_TV,'image_size',[M,N]);
[Aest sest]=TV_WSNMF(mixed,c,opt_mult);
% [Aest sest]=WSNMF(YY,c,opt_mult);%% Graph regularized NMF
% % construct the graph 
% options = [];
% options.NeighborMode = 'KNN';
% options.k = 3;
% options.WeightMode = 'HeatKernel';
% % options.WeightMode = 'Binary';
% options.t = 1;  
% Graph = constructW(YY',options);
% % 
% opts = struct('maxiter',30,'tol',1e-4,'trackit',20,'w',Ainit,'h',sinit,'alpha',0.15);
% [Aest sest]=GSNMF(YY,c,opts,Graph);  
%% permute results
CRD = corrcoef([A Aest]);
DD = abs(CRD(c+1:2*c,1:c));  
perm_mtx = zeros(c,c);
aux=zeros(c,1);
for i=1:c
    [ld cd]=find(max(DD(:))==DD); 
    ld=ld(1);cd=cd(1); % in the case of more than one maximum
    perm_mtx(ld,cd)=1; 
    DD(:,cd)=aux; DD(ld,:)=aux';
end
Aest = Aest*perm_mtx;
sest = sest'*perm_mtx;
Sest = reshape(sest,[M,N,c]);
sest = sest';
%% quantitative evaluation of spectral signature and abundance
E_rmse =zeros(1,c);
for i=1:c
    E_rmse(i)=sqrt(sum((abf(i,:)-sest(i,:)).^2)/(M*N));
end
RMSE = mean(E_rmse)
 SADerr = zeros(c,c);
for i =1:c
    for j = 1:c
    SADerr(i,j) = acos(A(:,j)'*Aest(:,i)/norm(A(:,j))/norm(Aest(:,i)));
    end
end
SAD = mean(diag(SADerr))
rel = norm(A*abf-Aest*sest)/norm(A*abf)

result(1,ii,jj,zz) = RMSE;result(2,ii,jj,zz) = SAD;result(3,ii,jj,zz) = rel;
        end
    end
end

%  figure();imagesc(Sest(:,:,4));   colorbar    
