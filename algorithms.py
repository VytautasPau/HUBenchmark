import matlab.engine
import numpy as np
import matlab
from sklearn.metrics import mean_squared_error
import experiment
from Algorithms.CNMF.CNMF import *



def sunsal(M, y, x_true):
    """
    Function to run sunsal algorithm

    Parameters
        M : array
            array of endmembers shape (WL, N) - wavelength * number of endmembers
        
        y : array
            HSI image flattened shape (WL, X) - wavelength * (pixels_x * pixels_y) flattened

        x_true : array
            GT abundances shape (N, X) - endmembers * (pixels_x * pixels_y) flattened
    """
    eng = matlab.engine.start_matlab()
    s = eng.genpath('Algorithms/SUnSAL')
    eng.addpath(s, nargout=0)
    try:
        ret = eng.sunsal(matlab.double(M.tolist()), matlab.double(y.tolist()))
        val = mean_squared_error(x_true, ret, squared=False)
        sre = experiment.Experiment.SRE(x_true, ret)
    except Exception as e:
        val = 0
        sre = e
    print("Sunsal results: ", val, sre)
    return ret, val, sre


def sunsal_tv(M, y, x_true, shape):
    """
    Function to run sunsal-tv algorithm

    Parameters
        M : array
            array of endmembers shape (WL, N) - wavelength * number of endmembers
        
        y : array
            HSI image flattened shape (WL, X) - wavelength * (pixels_x * pixels_y) flattened

        x_true : array
            GT abundances shape (N, X) - endmembers * (pixels_x * pixels_y) flattened

        shape : array
            original shape of image [pixels_x, pixels_y]
    """
    eng = matlab.engine.start_matlab()
    s = eng.genpath('Algorithms/SUnSAL-TV')
    eng.addpath(s, nargout=0)
    try:
        ret = eng.sunsal_tv(matlab.double(M.tolist()), matlab.double(y.tolist()), "LAMBDA_TV", 0.05, "LAMBDA_1", 0.02, 'IM_SIZE', matlab.int64([shape[0], shape[1]]))
        val = mean_squared_error(x_true, ret, squared=False)
        sre = experiment.Experiment.SRE(x_true, ret)
    except Exception as e:
        ret = 0
        val = 0
        sre = e
    print("Sunsal-TV results: ", val, sre)
    return ret, val, sre


def sgsnmf(M, y, x_true):
    """
    Function to run sgsnmf algorithm

    Parameters
        M : array
            array of endmembers shape (WL, N) - wavelength * number of endmembers
        
        y : array
            HSI image shape (x, y, WL) - wavelength * pixels_x * pixels_y 

        x_true : array
            GT abundances shape (N, X) - endmembers * (pixels_x * pixels_y) flattened
    """
    eng = matlab.engine.start_matlab()
    s = eng.genpath('Algorithms/SGSNMF')
    eng.addpath(s, nargout=0)
    try:
        W, H = eng.demo(matlab.double(y.tolist()), 6, 0.5, M.shape[1], 0.3, 0.05, 100, 600, nargout=2)
        val = mean_squared_error(x_true, H, squared=False)
        sre = experiment.Experiment.SRE(x_true, H)
    except Exception as e:
        H = 0
        W = 0
        val = 0
        sre = e
    print("SGSNMF results: ", val, sre)
    return W, H, val, sre


def s2wsu(M, y, x_true, shape):
    """
    Function to run s2wsu algorithm

    Parameters
        M : array
            array of endmembers shape (WL, N) - wavelength * number of endmembers
        
        y : array
            HSI image flattened shape (WL, X) - wavelength * (pixels_x * pixels_y) flattened

        x_true : array
            GT abundances shape (N, X) - endmembers * (pixels_x * pixels_y) flattened
    """
    params = {'itera': 50, 'lmb': 0.001, 'mu': 0.005, 'one': 'no', 'pos': 'yes'}
    eng = matlab.engine.start_matlab()
    s = eng.genpath('Algorithms/S2WSU')
    eng.addpath(s, nargout=0)
    try:
        ret = eng.sunsal_tv_lw_sp(matlab.double(M.tolist()), matlab.double(y.tolist()), 'AL_ITERS',params['itera'], 'LAMBDA_1', params['lmb'],
                     'POSITIVITY', params['pos'], 'ADDONE', params['one'], 'IM_SIZE', matlab.int64([shape[0], shape[1]]), 'MU', params['mu'])
        val = mean_squared_error(x_true, ret, squared=False)
        sre = experiment.Experiment.SRE(x_true, ret)
    except Exception as e:
        val = 0
        sre = e
    print("S2WSU results: ", val, sre)
    return ret, val, sre


def rsnmf(M, y, x_true):
    """
    Function to run sgsnmf algorithm

    Parameters
        M : array
            array of endmembers shape (WL, N) - wavelength * number of endmembers
        
        y : array
            HSI image shape (x, y, WL) - wavelength * pixels_x * pixels_y 

        x_true : array
            GT abundances shape (N, X) - endmembers * (pixels_x * pixels_y) flattened
    """
    eng = matlab.engine.start_matlab()
    s = eng.genpath('Algorithms/RSNMF')
    eng.addpath(s, nargout=0)
    try:
        W, H = eng.demo(matlab.double(y.tolist()), M.shape[1], 1000, 1e-6, 20,  0.01, 100, 0.02 , nargout=2)
        val = mean_squared_error(x_true, H, squared=False)
        sre = experiment.Experiment.SRE(x_true, H)
    except Exception as e:
        H = 0
        W = 0
        val = 0
        sre = e
    print("RSNMF results: ", val, sre)
    return W, H, val, sre


def rconmf(M, y, x_true):
    """
    Function to run rconmf algorithm

    Parameters
        M : array
            array of endmembers shape (WL, N) - wavelength * number of endmembers
        
        y : array
            HSI image flattened shape (WL, X) - wavelength * (pixels_x * pixels_y) flattened

        x_true : array
            GT abundances shape (N, X) - endmembers * (pixels_x * pixels_y) flattened
    """
    eng = matlab.engine.start_matlab()
    s = eng.genpath('Algorithms/R-CoNMF')
    eng.addpath(s, nargout=0)
    try:
        A, X, err, L = eng.demo_nopam(matlab.double(y.tolist()), M.shape[1], nargout=4)
        val = mean_squared_error(x_true, X, squared=False)
        sre = experiment.Experiment.SRE(x_true, X)
    except Exception as e:
        A = 0
        X = 0
        val = 0
        sre = e
    print("R-CoNMF results: ", val, sre)
    return A, X, val, sre


def almm(M, y, x_true, L, p, shape):
    """
    Function to run almm algorithm

    Parameters
        M : array
            array of endmembers shape (WL, N) - wavelength * number of endmembers
        
        y : array
            HSI image flattened shape (WL, X) - wavelength * (pixels_x * pixels_y) flattened

        x_true : array
            GT abundances shape (N, X) - endmembers * (pixels_x * pixels_y) flattened
        
        L : int
            number of bands/wavelengths

        p : int
            number of endmembers
        
        shape : array
            original shape of image [pixels_x, pixels_y]
    """
    eng = matlab.engine.start_matlab()
    s = eng.genpath('Algorithms/ALMM')
    eng.addpath(s, nargout=0)
    s = eng.genpath('functions')
    eng.addpath(s, nargout=0)
    try:
        res = eng.run(matlab.double(M.tolist()), matlab.double(y.tolist()),
              float(L), float(p), shape[0], shape[1], 100, 0.002, 0.002, 0.005, 0.005)
        res = np.nan_to_num(res)
        val = mean_squared_error(x_true, res, squared=False)
        sre = experiment.Experiment.SRE(x_true, res)
    except Exception as e:
        res = 0
        val = 0
        sre = e
    print("ALMM results: ", val, sre)
    return res, val, sre


def cnmf(M, y, x_true, shape):
    """
    Function to run cnmf algorithm

    Parameters
        M : array
            array of endmembers shape (WL, N) - wavelength * number of endmembers
        
        y : array
            HSI image flattened shape (WL, X) - wavelength * (pixels_x * pixels_y) flattened

        x_true : array
            GT abundances shape (N, X) - endmembers * (pixels_x * pixels_y) flattened
    """

    HSI = y
    MSI = y

    rows1 = shape[0]
    cols1 = shape[1]
    rows2 = shape[0]
    cols2 = shape[1]

    bands1 = MSI.shape[0]
    bands2 = HSI.shape[0]

    # parameters
    th_h = 1e-8 # Threshold of change ratio in inner loop for HS unmixing
    th_m = 1e-8 # Threshold of change ratio in inner loop for MS unmixing
    th2 = 1e-2 # Threshold of change ratio in outer loop
    sum2one = 2*( MSI.mean()/0.7455)**0.5 / bands1**3 # Parameter of sum to 1 constraint

    if bands1 == 1:
        I1 = 100 # Maximum iteration of inner loop
        I2 = 1 # Maximum iteration of outer loop
    else:
        I1 = 200 # Maximum iteration of inner loop (200-300)
        I2 = 1 # Maximum iteration of outer loop (1-3)

    # initialization of H_hyper
    # 0: constant (fast)
    # 1: nonnegative least squares (slow)
    init_mode = 0

    # avoid nonnegative values
    HSI[np.nonzero(HSI<0)] = 0

    w = 1
    M_num = M.shape[-1]

    R = np.eye(M.shape[0])

    verbose = "off"
    try:
        print("start")
        HSI, W_hyper, H_hyper, RMSE_h= CNMF_init(rows1,cols1,w,M_num,HSI,MSI,sum2one,I1,th_h,th_m,R,init_mode, 0, 'off', 0)

        cost = np.zeros((2,I2+1))
        cost[0,0] = RMSE_h

        # CNMF Iteration
        for i in range(I2):  # W_hyper - Endmember, H_hyper - Abundance
            W_hyper, H_hyper, RMSE_h = CNMF_ite(rows1,cols1,w,M,HSI,MSI,W_hyper,H_hyper,None,None,I1,th_h,th_m,I2,i,R,0,'off')

            cost[0,i+1] = RMSE_h

            if (cost[0,i]-cost[0,i+1])/cost[0,i]>th2  and i<I2-1:
                pass
            elif i == I2-1:
                if verbose == 'on':
                    print('Max outer interation.')
            else:
                if verbose == 'on':
                    print('END')
                break
        val = mean_squared_error(x_true, H_hyper, squared=False)
        sre = experiment.Experiment.SRE(x_true, H_hyper)
    except Exception as e:
        val = 0
        sre = e
    print(val, sre)
    return H_hyper, val, sre


if __name__ == "__main__":
    sunsal(np.ones((100, 21)), np.ones((100, 1500)), np.ones((21, 1500)))
    sunsal_tv(np.ones((100, 21)), np.ones((100, 1500)), np.ones((21, 1500)), [150, 10])
    sgsnmf(np.ones((100, 21)), np.ones((150, 10, 100)), np.ones((21, 1500)))
    s2wsu(np.ones((100, 21)), np.ones((100, 1500)), np.ones((21, 1500)), [150, 10])
    rsnmf(np.ones((100, 21)), np.ones((150, 10, 100)), np.ones((21, 1500)))
    rconmf(np.ones((100, 21)), np.ones((100, 1500)), np.ones((21, 1500)))
    cnmf(np.ones((100, 21)), np.ones((100, 1500)), np.ones((21, 1500)), [150, 10])
    almm(np.ones((100, 21)), np.ones((100, 1500)), np.ones((21, 1500)), 100, 21, [150, 10])