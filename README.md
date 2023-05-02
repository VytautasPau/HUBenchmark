# HUBenchmark

## Installation instructions

`Instruction on how to install all the required packages and libraries. The instructions given are for linux environments (specifically Ubuntu) as this was the environment used in development. For other OS'es the steps should be similar.`

`As a prerequisite Matlab needs to be installed on the machine.` 

`For Python installation pipenv virtual environment is used. To install you need pip and pipenv packages for Python.`

Then run (you can specify python version with --python 3.x):

```properties
pipenv install
```

Enter the environment with:

```properties
pipenv shell
```

Then Matlab engine needs to be install into this python environment
(official tutorial https://ch.mathworks.com/help/matlab/matlab_external/install-the-matlab-engine-for-python.html):

write permissions to folders build and dist (inside ../extern/engines/python/ folder) are required to install the pacakge successfully.

```properties
cd /path/to/MATLAB/R202xb/extern/engines/python/
python3 -m pip install .
```

Test the matlab installation with these commands

```properties
python3

import matlab.engine
eng = matlab.engine.start_matlab()
```

for matlab "Statistics and Machine Learning Toolbox" is required

## Algorithms used in the experiments

### SGSNMF
https://codeocean.com/capsule/2018026/tree/v2

Wang, Xinyu & Zhong, Yanfei & Zhang, Liangpei & Xu, Yanyan. (2017). Spatial Group Sparsity Regularized Nonnegative Matrix Factorization for Hyperspectral Unmixing. IEEE Transactions on Geoscience and Remote Sensing. PP. 1-18. 10.1109/TGRS.2017.2724944. 

### ALMM

https://github.com/danfenghong/ALMM_TIP

D. Hong, N. Yokoya, J. Chanussot and X. X. Zhu, "An Augmented Linear Mixing Model to Address Spectral Variability for Hyperspectral Unmixing," in IEEE Transactions on Image Processing, vol. 28, no. 4, pp. 1923-1938, April 2019, doi: 10.1109/TIP.2018.2878958.


### CNMF

https://naotoyokoya.com/Download.html

N. Yokoya, T. Yairi and A. Iwasaki, "Coupled Nonnegative Matrix Factorization Unmixing for Hyperspectral and Multispectral Data Fusion," in IEEE Transactions on Geoscience and Remote Sensing, vol. 50, no. 2, pp. 528-537, Feb. 2012, doi: 10.1109/TGRS.2011.2161320.

### R-CoNMF

http://www.lx.it.pt/~bioucas/code.htm

J. Li, J. M. Bioucas-Dias, A. Plaza and L. Liu, "Robust Collaborative Nonnegative Matrix Factorization for Hyperspectral Unmixing," in IEEE Transactions on Geoscience and Remote Sensing, vol. 54, no. 10, pp. 6076-6090, Oct. 2016, doi: 10.1109/TGRS.2016.2580702.

### SuNSAL

http://www.lx.it.pt/~bioucas/code.htm

J. M. Bioucas-Dias and M. A. T. Figueiredo, "Alternating direction algorithms for constrained sparse regression: Application to hyperspectral unmixing," 2010 2nd Workshop on Hyperspectral Image and Signal Processing: Evolution in Remote Sensing, Reykjavik, Iceland, 2010, pp. 1-4, doi: 10.1109/WHISPERS.2010.5594963.

### SuNSAL-TV

http://www.lx.it.pt/~bioucas/code.htm

M. -D. Iordache, J. M. Bioucas-Dias and A. Plaza, "Total Variation Spatial Regularization for Sparse Hyperspectral Unmixing," in IEEE Transactions on Geoscience and Remote Sensing, vol. 50, no. 11, pp. 4484-4502, Nov. 2012, doi: 10.1109/TGRS.2012.2191590.

### S2WSU

Algorithm is part of the repository https://github.com/ricardoborsoi/MUA_SparseUnmixing

 S. Zhang, J. Li, H.-C. Li, C. Deng and A. Plaza. Spectral-Spatial Weighted Sparse Regression for Hyperspectral Image Unmixing. IEEE Transactions on Geoscience and Remote Sensing, 2018


### RSNMF

https://prowdiy.github.io/weihe.github.io/code/TV_RSNMF_public.zip

W. He, H. Zhang and L. Zhang, "Total Variation Regularized Reweighted Sparse Nonnegative Matrix Factorization for Hyperspectral Unmixing," in IEEE Transactions on Geoscience and Remote Sensing, vol. 55, no. 7, pp. 3909-3921, July 2017, doi: 10.1109/TGRS.2017.2683719.


## Data used

USGS spectral library version 7 for synthetic data generation
https://pubs.er.usgs.gov/publication/ds1035 
https://crustal.usgs.gov/speclab/QueryAll07a.php


Hyperspectral cube and area classification file from IEEE Data Fusion Contest 2018
https://site.ieee.org/france-grss/2018/01/16/data-fusion-contest-2018-contest-open/
https://hyperspectral.ee.uh.edu/?page_id=1075
Data download link: http://hyperspectral.ee.uh.edu/QZ23es1aMPH/2018IEEE/phase2.zip
for default usage extract to Benchmark/phase2 folder. After extraction Benchmar/pahse2 should contain "2018IEEE_Contest" folder and its contents


## Running benchmark code and algorithm code

Run dataset.py to generate the benchmark datasets. 
To get the parameters run 
```
python3 dataset.py -h
```
No parameters are required as defaults are provided. Only the manual download of ieee dataset is needed


For testing purposes algorithms are run using dummy information using:
```
python3 algorithms.py 
```

To run the created benchmark dataset through given algorithms use benchmark.py

```
python3 benchmark.py 
```

Default parameters are given. Paths and other parameters can be changed in settings.py file
