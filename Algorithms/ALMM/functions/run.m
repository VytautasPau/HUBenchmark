function [A_est, S_est, B_est, E_est, A_truth_patch, EM_est, AB_map] = run(M, Y, L, p, x, y, num, alfa, beta, gama, eta)

    %% initializing the spectral variability dictionary
    E_random = orth(randn(L,1000));
    % num = 100; %the number of atoms in the spectral variability dictionary
    E_init = E_random(:,1:num);
    
    Y3d = reshape(Y', x, y, L);

    num_endmembers = p; %the number of endmembers
    endmembers = VCA(Y, 'Endmembers', num_endmembers, 'SNR', 30);
    s = 1 - pdist2(endmembers', M', 'cosine');
    [mi, ind] = sort(s, 'descend');
    index = ind(1, :);

    %% parameter setting in ALMM
    param.alfa = alfa;
    param.beta = beta;
    param.gama = gama;
    param.eta  = eta;
    
    param.mk   = 10; % the length or width of the patch (square)
    maxiter = 100;

    %% run ALMM to unmix HSI

    [A_est, S_est, B_est, E_est, A_truth_patch, EM_est, AB_map] = ALMM(Y3d, endmembers, E_init, param, maxiter, 'Blind');

end
