function [W H ]=GSNMF(V,r,opts,Graph)

% for L1/2 sparse， ref lambda /5 and ref delta = 5; 
defopts=struct('maxiter',1000,'tol',1e-6,'trackit',20,'w',[],'h',[],'alpha',[]);
if ~exist('opts','var')
    opts=struct;
end
[MaxIt, tol, trackit,W,H,alpha]=scanparam(defopts,opts);


eps=1e-9;

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
end
AS = sum(H);
H = H./repmat(AS,size(H,1),1);

%% compute the laplace matrix
    Graph = alpha*Graph;
    DCol = full(sum(Graph,2));
    D = spdiags(DCol,0,L,L);
    Lap = D - Graph;
%% sparsity
attend = zeros(1,M);
for i = 1:M
    attend(i)= (sqrt(L)- norm(V(i,:),1)/norm(V(i,:),2))/(sqrt(L-1));
end
% lambda = sum(attend)/sqrt(M);
lambda = sum(attend)/sqrt(M)/1;
%%%%%%%%%%%%sum to 1 or not
delta = 1.5e1; Vo = [V;delta*ones(1,L)];
%%%%%%%%%%%
% I=eye(r,r);
obj=inf;
for it=1:MaxIt
    
    W0=W;
    H0 = H;
    W=W.*((V*H')./max(W*H*H',eps));
  
    WE = [W;delta*ones(1,r)];
    idx = find(H<=1e-4); PG = (max(H,eps)).^(-0.5); PG(idx) = 0;
    H=H.*((WE'*Vo+H*Graph)./max((WE'*WE)*H + 0.5*lambda*PG + H*D,eps));
%     H=H.*((WE'*Vo+H*Graph)./max((WE'*WE)*H + lambda*(abs(H.^(-1)))+ H*D,eps)); %graph regularized reweighted sparse
%     H=H.*((WE'*Vo+H*Graph)./max((WE'*WE)*H +  H*D,eps)); %Graph Resularied
%      H=H.*((WE'*Vo)./max((WE'*WE)*H,eps)); %Graph Resularied
% 
    if (trackit>0)&&(~rem(it,trackit))&&(it>MaxIt*0.2)  %mean trackit >0, it是其整数倍，并且大于0.2 
        obj(it)=max(norm(W-W0,'fro'),norm(H-H0,'fro'));  
%         objH = norm(H-H0,'fro');
        if obj(it)<tol %&&  objH<tol
            break;
        end    
    end
end


