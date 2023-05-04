import os
import algorithms
import settings
import argparse
import numpy as np


def run_sunsal(endm, abd, img):
    shp = abd.shape
    ret, val, sre = algorithms.sunsal(endm.T, np.reshape(img, (shp[0] * shp[1], img.shape[-1])).T,
                                 np.reshape(abd, (shp[0] * shp[1], shp[2])).T)
    return "sunsal", [ret, val, sre]


def run_sunsal_tv(endm, abd, img):  # takes a long time and lots of resources for big images
    shp = abd.shape
    ret, val, sre = algorithms.sunsal_tv(endm.T, np.reshape(img, (shp[0] * shp[1], img.shape[-1])).T,
                                 np.reshape(abd, (shp[0] * shp[1], shp[2])).T, [shp[0], shp[1]])
    return "sunsal_tv", [ret, val, sre]


def run_sgsnmf(endm, abd, img):  # takes a long time and lots of resources for big images
    shp = abd.shape
    W, H, val, sre = algorithms.sgsnmf(endm.T, img, np.reshape(abd, (shp[0] * shp[1], shp[2])).T)
    return "sgsnmf", [W, H, val, sre]


def run_s2wsu(endm, abd, img):  # takes a long time and lots of resources for big images
    shp = abd.shape
    ret, val, sre = algorithms.s2wsu(endm.T, np.reshape(img, (shp[0] * shp[1], img.shape[-1])).T,
                                        np.reshape(abd, (shp[0] * shp[1], shp[2])).T, [shp[0], shp[1]])
    return "s2wsu", [ret, val, sre]


def run_rsnmf(endm, abd, img):  # takes a long time and lots of resources for big images
    shp = abd.shape
    W, H, val, sre = algorithms.rsnmf(endm.T, img, np.reshape(abd, (shp[0] * shp[1], shp[2])).T)
    return "rsnmf", [W, H, val, sre]


def run_rconmf(endm, abd, img):  
    shp = abd.shape
    A, X, val, sre = algorithms.rconmf(endm.T, np.reshape(img, (shp[0] * shp[1], img.shape[-1])).T,
                                 np.reshape(abd, (shp[0] * shp[1], shp[2])).T)
    return "rconmf", [A, X, val, sre]


def run_cnmf(endm, abd, img):  
    shp = abd.shape
    H_hyper, val, sre = algorithms.cnmf(endm.T, np.reshape(img, (shp[0] * shp[1], img.shape[-1])).T,
                                 np.reshape(abd, (shp[0] * shp[1], shp[2])).T, [shp[0], shp[1]])
    return "cnmf", [H_hyper, val, sre]


def run_almm(endm, abd, img):  # takes a long time and lots of resources for big images
    shp = abd.shape
    shp1 = endm.shape
    res, val, sre = algorithms.almm(endm.T, np.reshape(img, (shp[0] * shp[1], img.shape[-1])).T,
                                 np.reshape(abd, (shp[0] * shp[1], shp[2])).T, shp1[1], shp1[0], [shp[0], shp[1]])
    return "almm", [res, val, sre]


functions = [run_sunsal, run_sunsal_tv, run_sgsnmf, run_s2wsu, run_rsnmf, run_rconmf, run_cnmf]
# functions = [run_sunsal, run_almm]


def run_exp1(data_folder, out_folder, iterations=10):
    """
    Function to run experiment 1 through algorithms

    Parameters
        data_folder : str
            input data folder (output from experiment1 function)
        
        out_folder : str
            location to put the results
        
        iterations : int
            number of iteration that were used in experiment1 creation
    """

    exp1_folder = os.path.join(data_folder, "exp1", "dataset")

    out_folder = os.path.join(out_folder, "exp1", "out")
    if not os.path.isdir(out_folder):
        os.makedirs(out_folder)

    # read dataset files
    # endmembers shape [N ,WL]
    # files shape [N]
    # abundances shape [x, y, N]
    # image shape [x, y, WL]
    endm = np.load(os.path.join(exp1_folder, "endmembers.npy"))  
    files = np.load(os.path.join(exp1_folder, "filenames.npy"))  

    for i in range(iterations):
        abd = np.load(os.path.join(exp1_folder, f"abundance_{i}.npy"))
        img = np.load(os.path.join(exp1_folder, f"image_{i}.npy"))

        # Downscale images for testing purposes
        abd = abd[::10, ::10, :]
        img = img[::10, ::10, :]

        for func in functions:
            alg, res = func(endm, abd, img)
            for j, val in enumerate(res):
                np.save(os.path.join(out_folder, f"{alg}_{i}_{j}.npy"), np.array(val))  # save as algorithm_iteration_result.npy
        break


def run_exp2(data_folder, out_folder, iterations=1, noises=None):
    """
    Function to run experiment 2 through algorithms

    Parameters
        data_folder : str
            input data folder (output from experiment2 function)
        
        out_folder : str
            location to put the results
        
        iterations : int
            number of iteration that were used in experiment2 creation
    """

    exp2_folder = os.path.join(data_folder, "exp2", "dataset")

    out_folder = os.path.join(out_folder, "exp2", "out")
    if not os.path.isdir(out_folder):
        os.makedirs(out_folder)

    # read dataset files
    # endmembers shape [N ,WL]
    # files shape [N]
    # abundances shape [x, y, N]
    # image shape [x, y, WL]
    endm = np.load(os.path.join(exp2_folder, "endmembers.npy"))  
    files = np.load(os.path.join(exp2_folder, "filenames.npy"))  
    if noises is None:
        noises = settings.default_noises
        noises.append("real")

    for i in range(iterations):
        for ns in noises:
            abd = np.load(os.path.join(exp2_folder, f"abundance_{i}_{ns}.npy"))
            img = np.load(os.path.join(exp2_folder, f"image_{i}_{ns}.npy"))

            # Downscale images for testing purposes
            abd = abd[::10, ::10, :]
            img = img[::10, ::10, :]

            for func in functions:
                alg, res = func(endm, abd, img)
                for j, val in enumerate(res):
                    np.save(os.path.join(out_folder, f"{alg}_{i}_{ns}_{j}.npy"), np.array(val))  # save as algorithm_iteration_noise_result.npy
        break


def run_exp3(data_folder, out_folder, iterations=10, reduction=2):
    """
    Function to run experiment 2 through algorithms

    Parameters
        data_folder : str
            input data folder (output from experiment3 function)
        
        out_folder : str
            location to put the results
        
        iterations : int
            number of iteration that were used in experiment3 creation
    """

    exp3_folder = os.path.join(data_folder, f"exp3_{reduction}", "dataset")

    out_folder = os.path.join(out_folder, f"exp3_{reduction}", "out")
    if not os.path.isdir(out_folder):
        os.makedirs(out_folder)

    # read dataset files
    # endmembers shape [N ,WL]
    # files shape [N]
    # abundances shape [x, y, N]
    # image shape [x, y, WL]
    endm = np.load(os.path.join(exp3_folder, "endmembers.npy"))  
    files = np.load(os.path.join(exp3_folder, "filenames.npy"))  

    for i in range(iterations):
        abd = np.load(os.path.join(exp3_folder, f"abundance_{i}.npy"))
        img = np.load(os.path.join(exp3_folder, f"image_{i}.npy"))

        # Downscale images for testing purposes
        abd = abd[::10, ::10, :]
        img = img[::10, ::10, :]

        for func in functions:
            alg, res = func(endm, abd, img)
            for j, val in enumerate(res):
                np.save(os.path.join(out_folder, f"{alg}_{i}_{j}.npy"), np.array(val))  # save as algorithm_iteration_noise_result.npy
        break


def main(args):
    # use settings if parameters are empty
    if args['outfolder'] is None:
        args['outfolder'] = settings.dataset_root
    if args['resultfolder'] is None:
        args['resultfolder'] = settings.out_root

    run_exp1(args['outfolder'], args['resultfolder'])
    run_exp2(args['outfolder'], args['resultfolder'])
    run_exp3(args['outfolder'], args['resultfolder'], reduction=2)
    run_exp3(args['outfolder'], args['resultfolder'], reduction=3)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-o', '--outfolder', type=str, dest="outfolder", help="An alternative dataset output folder")
    parser.add_argument('-r', '--resultfolder', type=str, dest="resultfolder", help="An alternative result output folder")
    parser.add_argument('arg', nargs='*')
    parsed = parser.parse_args()
    main(vars(parsed))