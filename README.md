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

## Running benchmark code and algorithm code

`WIP`