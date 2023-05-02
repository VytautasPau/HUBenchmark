import os

# Get the main root path
root_folder = os.path.dirname(os.path.realpath(__file__))

# main dataset folder
dataset_root = os.path.join(root_folder, "Datasets")

# main benchmark folder
benchmark_root = os.path.join(root_folder, "Benchmark") 

# main algorithm folder
algorithm_root = os.path.join(root_folder, "Algorithms")

# main output folder
out_root = os.path.join(root_folder, "Out")


# usgs library sample folder
usgs_folder = os.path.join(benchmark_root, "ASCIIdata_splib07b_cvHYPERION")
usgs_wavelength = os.path.join(benchmark_root, "WL.txt")

# ieee dataset path
ieee_folder = os.path.join(benchmark_root, "phase2")
ieee_dataset_image = os.path.join(*[ieee_folder, "2018IEEE_Contest", "Phase2", "TrainingGT", "2018_IEEE_GRSS_DFC_GT_TR.tif"])

default_endmembers_synthetic = [3,   4,   5,   6,   7,   8,   9,  10,  15,  20,  25,  30,  40, 50,  60,  70,  80,  90, 100]
default_noises = [20, 25, 30, 35, 40, 45, 50]