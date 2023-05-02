function [W H obj ]=TV_WSNMF(V,r,MaxIt, tol, trackit,W,H,lambda,mu,lambda_TV,image_size)
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
%defopts=struct('maxiter',1000,'tol',1e-6,'trackit',20,'w',[],'h',[],'lambda',0.2,'mu',1e3,'lambda_TV',1e-3,'image_size',[]);
%if ~exist('opts','var')
%    opts=struct;
%end
%[MaxIt, tol, trackit,W,H,lambda,mu,lambda_TV,image_size]=scanparam(defopts,opts);

eps=1e-12;

[M L]=size(V);
V=max(V,0);

  
%% Initialization;
if isempty(W)
%     rand('seed',243)
%       rand('seed',24)
    W=rand(M,r);
end
if isempty(H)
%     rand('seed',76)
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
%% reestimate parameters
% lambda_TV = lambda_TV*mu; 
%% TV operator
% % build handlers and necessary stuff
%     % horizontal difference operators
%     FDh = zeros(im_size);
%     FDh(1,1) = -1;
%     FDh(1,end) = 1;
%     FDh = fft2(FDh);
%     FDhH = conj(FDh);
%     
%     % vertical difference operator
%     FDv = zeros(im_size);
%     FDv(1,1) = -1;
%     FDv(end,1) = 1;
%     FDv = fft2(FDv);
%     FDvH = conj(FDv);
%     
%     IL = 1./( FDhH.* FDh + FDvH.* FDv + 1);
%     
%     Dh = @(x) real(ifft2(fft2(x).*FDh));
%     DhH = @(x) real(ifft2(fft2(x).*FDhH));
%     
%     Dv = @(x) real(ifft2(fft2(x).*FDv));
%     DvH = @(x) real(ifft2(fft2(x).*FDvH));
% for the TV norm
param2.verbose=1;
param2.max_iter=10;
param2.verbose = 0;
g1.prox=@(x, T) prox_TV(x, T*mu1/(2*tau), param2);
g1.norm=@(x) tau*TV_norm(x); 
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
    H=H.*((WE'*Vo + mu*X)./max((WE'*WE)*H +lambda*(abs((H+eps).^(-1))) + mu*H,eps)); % weighted sparse Total variation   
    %H=H.*((WE'*Vo)./max((WE'*WE)*H + lam1*(H-H*G-H*G'+H*G*G'),eps)); 
    % update X
    X = H;
    %disp(size(H)); disp(i); disp(size(H(1,:))); disp(image_size); disp(size(W));
   for i =1:r % each abundacne 
     z = prox_TV(reshape(H(i,:),image_size),2*lambda_TV/mu,param2);
     X(i,:) = z(:);
   end
    % check if convergence   
%     if (trackit>0)&&(~rem(it,trackit))&&(it>MaxIt*0.2)  %mean trackit >0, it是其整数倍，并且矿于0.2 
        obj(it)=max(norm(W-W0,'fro'),norm(H-H0,'fro'));  
%         objH = norm(H-H0,'fro');
        if obj(it)<tol %&&  objH<tol
            break;
        end    
    end
end


