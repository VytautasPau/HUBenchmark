function [W H ]=WSNMF(V,r,opts)
addpath './prox_operators'
% solver for  total variation weighted sparse NMF with column sum to 1
% need m>=n
%        min 1/2*||WH - V||_F^2 + lambda*||MH||_1+mu/2*||H-X||_F^2 + lambda_TV*||DX||_1,1, 
%        st.    X,Y >= 0, (e1)'*Y = (e2)'; e1 = ones(m,1) and e2 =
%        ones(n,1);
%
% Output:
%           W --- m x k matrix
%           H --- k x n matrix
%          Out --- output information
% Input:
%           V --- given partial matrix
%           k --- given estimate rank
%           opts --- option structure
%           M --- weighted matrix
%           D --- total variation operators
% by He Wei 2014/8/15
defopts=struct('maxiter',1000,'tol',1e-6,'trackit',20,'w',[],'h',[],'lambda',0.2,'mu',1e3,'lambda_TV',1e-3,'image_size',[]);
if ~exist('opts','var')
    opts=struct;
end
[MaxIt, tol, trackit,W,H,lambda,mu,lambda_TV,image_size]=scanparam(defopts,opts);

eps=1e-12;

[M L]=size(V);
V=max(V,0);

  
%% Initialization;
if isempty(W)
    rand('seed',243)
%       rand('seed',24)
    W=rand(M,r);
end
if isempty(H)
    rand('seed',76)
%     rand('seed',156)
    H=rand(r,L);
    AS = sum(H);
    H = H./repmat(AS,size(H,1),1);
end
X = H;
%% sparsity
attend = zeros(1,M);
for i = 1:M
    attend(i)= (sqrt(L)- norm(V(i,:),1)/norm(V(i,:),2))/(sqrt(L-1));
end
% lambda = sum(attend)/sqrt(M);
% lambda = sum(attend)/sqrt(M)/5;
%%%%%%%%%%%%sum to 1 or not
delta = 1.5e1; Vo = [V;delta*ones(1,L)];
%%%%%%%%%%%
%%
% I=eye(r,r);
obj=inf;
for it=1:MaxIt
    % update W
    W0=W;
    H0 = H;
    W=W.*((V*H')./max(W*H*H',eps));
    % update H
    WE = [W;delta*ones(1,r)];
%     idx = find(H<=1e-4); PG = (max(H,eps)).^(-0.5); PG(idx) = 0;        % L1/2 sparse Total variation
%     H=H.*((WE'*Vo + mu*X)./max((WE'*WE)*H +0.5*lambda*PG + mu*H,eps)); % L1/2 sparse Total variation
    H=H.*((WE'*Vo)./max((WE'*WE)*H +lambda*(abs(H.^(-1))),eps)); % weighted sparse Total variation   
    %H=H.*((WE'*Vo)./max((WE'*WE)*H + lam1*(H-H*G-H*G'+H*G*G'),eps)); 
    
    % check if convergence   
    if (trackit>0)&&(~rem(it,trackit))&&(it>MaxIt*0.2)  %mean trackit >0, it是其整数倍，并且大于0.2 
        obj(it)=max(norm(W-W0,'fro'),norm(H-H0,'fro'));  
%         objH = norm(H-H0,'fro');
        if obj(it)<tol %&&  objH<tol
            break;
        end    
    end
end


