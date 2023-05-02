function [Ahat,Xhat,rerr,L] = demo_nopam(Y, q)
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


[Ahat,Xhat,rerr,L] = conmf(Y,q, 'VERBOSE','no', 'PLOT_A', 'no');


    
