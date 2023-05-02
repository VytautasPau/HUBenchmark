function [Ahat,Xhat,rerr,L] = demo(Y, q, pos, alpha, beta1, addone, aoiter, delta, sunsaliter, mua, mux, sphere1, min_vol )
%  demo_Cuprit
%
%  This demo illustrates the collaborative hyperspectral unmixing via CoNMF
%  for the Cuprit data.
%        
%         
%  See
%
% J. Li, J. M. Bioucas-Dias, A. Plaza and L. Liu, "Robust Collaborative 
% Nonnegative Matrix Factorization for Hyperspectral Unmixing," 
% in IEEE Transactions on Geoscience and Remote Sensing, vol. 54, no. 10, 
% pp. 6076-6090, Oct. 2016. doi: 10.1109/TGRS.2016.2580702
%
%
%  -----------------------------------------------------------------------
%
% Author: Jun Li, Jose Bioucas-Dias, February, November, 2014

[L,n] = size(Y);  % matrix with  L(channels) x N(pixels)


[Ahat,Xhat,rerr,L] =  ...
       conmf(Y,q, ...
            'POSITIVITY', pos, ...
            'ALPHA', alpha, ...     %l_21 regularization parameter
            'BETA',  beta1, ...      %minimum volume regularization parameter
            'ADDONE', addone, ...
            'AO_ITERS', aoiter, ...
            'DELTA', delta,  ...    % (STOP) relative reconstruction error
            'CSUNSAL_ITERS', sunsaliter, ...
            'MU_A', double(mua), ...  %proximity weight for A
            'MU_X', double(mux), ...      %proximity weight for X
            'SPHERIZE', sphere1, ...         %{'no','cov', 'M'}
            'MIN_VOLUME', min_vol, ...  %{'boundary', 'center', 'totalVar'} 
            'VERBOSE','no', ...
            'PLOT_A', 'no');


    
