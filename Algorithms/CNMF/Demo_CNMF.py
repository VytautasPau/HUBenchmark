'''
DEMO: COUPLED NONNEGATIVE MATRIX FACTORIZATION (CNMF)

This is a demo program of CNMF with synthetic HS and MS data
generated form airborne HS data

This demo requires numpy and scipy.

References:
[1] N. Yokoya, T. Yairi, and A. Iwasaki, "Coupled nonnegative matrix
    factorization unmixing for hyperspectral and multispectral data fusion,"
    IEEE Trans. Geosci. Remote Sens., vol. 50, no. 2, pp. 528-537, 2012.
[2] N. Yokoya, N. Mayumi, and A. Iwasaki, "Cross-calibration for data fusion
    of EO-1/Hyperion and Terra/ASTER," IEEE J. Sel. Topics Appl. Earth Observ.
    Remote Sens., vol. 6, no. 2, pp. 419-426, 2013.
[3] N. Yokoya, T. Yairi, and A. Iwasaki, "Hyperspectral, multispectral,
    and panchromatic data fusion based on non-negative matrix factorization,"
    Proc. WHISPERS, Lisbon, Portugal, Jun. 6-9, 2011.

Author: Naoto Yokoya
Email : yokoya@sal.rcast.u-tokyo.ac.jp
'''

import numpy as np
from CNMF import *

if __name__ == '__main__':
    # Read image
    filename = 'chikusei.bsq'
    cols1 = 240
    rows1 = 240
    bands1 = 128
    data = np.transpose( np.double(np.fromfile(filename, dtype = np.uint16, count = cols1 * bands1 * rows1).reshape(bands1, rows1, cols1) ), (1,2,0))
    hs_bands = np.r_[4:114]
    data = data[:,:,hs_bands] # Exclude noisy bands
    bands1 = data.shape[2]

    # Synthesize MSI
    print 'Synthesize MSI ...'
    with open('chikusei_spec.txt', "rU") as f:
        spec = map(lambda x:x.split(), f.read().strip().split("\n"))
    spec = np.array([[float(elm) for elm in v] for v in spec])
    wavelength = spec[hs_bands,0] # Center wavelength of HSI
    RapidEye_wavelength = np.array([[0.440, 0.510],[0.520, 0.590], [0.630, 0.690], [0.690, 0.730], [0.760, 0.880]]) # Spectral range of RapidEye
    bands2 = RapidEye_wavelength.shape[0] # Number of MSI bands
    srf = np.zeros((bands2,bands1))
    for b in range(bands2):
        b_i = np.nonzero(wavelength>RapidEye_wavelength[b,0])[0][0]
        b_e = np.nonzero(wavelength<RapidEye_wavelength[b,1])[0][-1]
        srf[b,b_i:b_e+1] = 1.0/(b_e+1-b_i) # Rectangle SRF
    MSI = np.dot(data.reshape(cols1*rows1,bands1), srf.transpose()).reshape(rows1,cols1,bands2) # Spectral simulation

    # Synthesize HSI
    print 'Synthesize HSI ...'
    w = 6 # GSD difference
    HSI = gaussian_down_sample(data,w) # Spatial simulation via Gaussian filtering

    # CNMF
    print 'Start CNMF ...'
    I_CNMF = CNMF_fusion(HSI,MSI)

    # Quality measures if reference is available
    psnr_all, psnr_mean = PSNR(data,I_CNMF)
    sam_mean, map = SAM(data,I_CNMF)
    print 'PSNR: ', psnr_mean, ' dB'
    print 'SAM : ', sam_mean, '  degree'