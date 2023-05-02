import os
import numpy as np
import argparse
import settings
import random
import rasterio


def experiment0(out_root, files, wavelengths, endmembers=None):
    """
    Function to create fully synthetic datasets for endmember robustness experiment
    !! Not used in publication to generate data

    Parameters
        out_root : str
            path to dataset out folder

        files : list
            list of material files
        
        wavelengths : numpy ndarray
            array of wavelenghts

        endmembers : list
            list of number of endmembers to use
    """
    exp1_out_path = os.path.join(out_root, "exp0")

    if not os.path.isdir(exp1_out_path):
        os.mkdir(exp1_out_path)

    # output all of the material files, used for dataset reconstruction
    with open(os.path.join(exp1_out_path, "filelist.txt"), 'w') as fl:
        for listitem in files:
            fl.write('%s\n' % listitem)

    # output wavelenghts
    np.save(os.path.join(exp1_out_path, "WL.npy"), wavelengths)

    # set list of number of endmembers to use. Given is the default for
    if endmembers is None:
        endmembers = settings.default_endmembers_synthetic
    else:
        assert type(endmembers) == list, "Given endmembers variable is not a list"

    # generate datasets
    # For each number of endmembers one set of uniform abundances and {iterations} number of random, sets of abundances and HSI images are created. 
    # This will generate a few gigabytes of data, due to created hyperspectral images. Output size will len(endms) * (iterations + 1) of images and abundances.
    iterations = 20
    base_folder = f"{exp1_out_path}/dataset"
    for i in endmembers:  # run for each number of endmembers selected
        print(i)
        endm, names = getEndmemberSet(files, i)  # collect random endmembers (influenced by the seed)
        folder_tmp = f'{base_folder}_{i}'
        if not os.path.isdir(folder_tmp):
            os.mkdir(folder_tmp)
        # save initial random endmembers and filenames for reproducibility
        np.save(os.path.join(folder_tmp, "endmembers.npy"), endm)
        np.save(os.path.join(folder_tmp, 'filenames.npy'), np.array(names))
        # create uniform abundance distribution
        abd1 = createAbundance(endm, uniform=True, pixel_size = np.array([150, 100]), image_size=np.array([1, 1]), threshold=0)
        mat1 = np.dot(abd1, endm)
        np.save(os.path.join(folder_tmp, 'abundance_uniform.npy'), np.array(abd1))
        np.save(os.path.join(folder_tmp, 'image_uniform.npy'), np.array(mat1))
        # create random sets of distributions
        for j in range(iterations):
            abd1 = createAbundance(endm, uniform=False, pixel_size = np.array([150, 100]), image_size=np.array([1, 1]))
            mat1 = np.dot(abd1, endm)
            np.save(os.path.join(folder_tmp, f'abundance_{j}.npy'), np.array(abd1))
            np.save(os.path.join(folder_tmp, f'image_{j}.npy'), np.array(mat1))


def experiment1(out_root, files, wavelengths, image_path=None):
    """
    Function to create datasets for endmember robustness experiment

    Parameters
        out_root : str
            path to dataset out folder

        files : list
            list of material files
        
        wavelengths : numpy ndarray
            array of wavelenghts

        endmembers : list
            list of number of endmembers to use

        image_path : str
            path to ieee ground truth image .tif file
    """
    exp1_out_path = os.path.join(out_root, "exp1")

    if not os.path.isdir(exp1_out_path):
        os.mkdir(exp1_out_path)

    # output all of the material files, used for dataset reconstruction
    with open(os.path.join(exp1_out_path, "filelist.txt"), 'w') as fl:
        for listitem in files:
            fl.write('%s\n' % listitem)

    # output wavelenghts
    np.save(os.path.join(exp1_out_path, "WL.npy"), wavelengths)

    # read IEEE data fusion contesst image
    if image_path is None:
        image_path = settings.ieee_dataset_image

    src = rasterio.open(image_path)
    array = src.read(1)
    src.close()
    print("Reading IEEE raster file. Image size = ", array.shape)

    endmembers = np.unique(array)

    # generate vector of endmembers
    iterations = 10
    vector = np.repeat(np.arange(min(endmembers) + 2, max(endmembers) + 2), iterations)  # from 2 to 22 (not included) endmembers 
    np.random.seed(100)
    np.random.shuffle(vector)  # to set different materials on different classes shuffle the vector data

    # generate datasets
    endm, names = getEndmemberSet(files, vector.max())
    folder_tmp = os.path.join(exp1_out_path, "dataset")
    if not os.path.isdir(folder_tmp):
        os.mkdir(folder_tmp)

    np.save(os.path.join(folder_tmp, "endmembers.npy"), endm)
    np.save(os.path.join(folder_tmp, 'filenames.npy'), np.array(names))

    for l, vec in enumerate(np.split(vector, iterations)):
        index = l
        uniform_pix = np.squeeze(createAbundance(endm, uniform=True, pixel_size = np.array([1, 1]),
                                                image_size=np.array([1, 1])))
        pixels = uniform_pix[np.newaxis, :]
        print(index)  # iteration index
        print(vec)  # generated calss to material mapping vector

        for i in vec:
            a = np.full(vector.max(), False)
            a[:i] = True
            np.random.shuffle(a)
            pix1 = np.squeeze(createAbundance(endm, uniform=False, pixel_size = np.array([1, 1]),
                                            image_size=np.array([1, 1])))
            pix1[a==False] = 0

            pix1 = pix1/np.sum(pix1)

            pixels = np.append(pixels, pix1[np.newaxis, :], axis=0)
            
        new_arr = array[:, :, np.newaxis]

        new_arr = np.repeat(new_arr, 21, axis=2)
        new_arr = new_arr.astype('float16')

        for i in range(pixels.shape[0]):
            new_arr[array == i, :] = np.squeeze(pixels[i])

        image = np.dot(new_arr, endm)
        image = image.astype('float16')

        np.save(f'{folder_tmp}/abundance_{index}.npy', np.array(new_arr))
        np.save(f'{folder_tmp}/image_{index}.npy', np.array(image))


def experiment2(out_root, input_folder, index=0, noise_list=None):
    """
    Function to create datasets for robustness to noise experiment

    Parameters
        out_root : str
            path to dataset out folder
        
        input_folder : str
            path to a dataset folder from experiment1 to use generated data as the input 

        index : str
            which iteration of experiment1 random abundances to use (has to be lower than the iterations variable set in experiment1).

        noise_list : list
            list of noised to generate (in dB)
    """
    exp2_out_path = os.path.join(out_root, "exp2")

    if not os.path.isdir(exp2_out_path):
        os.mkdir(exp2_out_path)

    folder_tmp = os.path.join(exp2_out_path, "dataset")
    if not os.path.isdir(folder_tmp):
        os.mkdir(folder_tmp)
    
    # read data from set input folder. (from experiment1 by default)
    endm = np.load(os.path.join(input_folder, f'endmembers.npy'))
    names = np.load(os.path.join(input_folder, f'filenames.npy'))
    noises = np.load(os.path.join(settings.benchmark_root, 'noises.npy'))  # noises generated from real camera configuration (non uniform).

    if noise_list is None:
        noise_list =  settings.default_noises

    np.save(os.path.join(folder_tmp, f'endmembers.npy'), endm)
    np.save(os.path.join(folder_tmp, f'filenames.npy'), names)

    iterations = 1  # has to be lower or equal to iteration set in experiment1 (if using experiment1 dataset)

    # add noise
    # for each dataset created (up to iterations count) in experiment1 add white noise and real noise and save images
    for index in range(iterations):
        # generate real noise
        new_arr = np.load(f'{input_folder}/abundance_{index}.npy')
        image = np.load(f'{input_folder}/image_{index}.npy')

        for i, noise in enumerate(list(noises)):
            if noise != 0:
                image[:, :, i] = addNoise(image[:, :, i], noise)

        np.save(os.path.join(folder_tmp, f'abundance_{index}_real.npy'), new_arr)
        np.save(os.path.join(folder_tmp, f'image_{index}_real.npy'), image)
        del new_arr
        del image

        # generate white noise
        new_arr = np.load(f'{input_folder}/abundance_{index}.npy')
        image = np.load(f'{input_folder}/image_{index}.npy')
        for i in noise_list:
            # Set a target SNR
            target_snr_db = i
            # Calculate signal power and convert to dB 
            sig_avg_watts = np.mean(image)
            sig_avg_db = 10 * np.log10(sig_avg_watts)
            noise_avg_db = sig_avg_db - target_snr_db
            noise_avg_watts = 10 ** (noise_avg_db / 10)
            # Generate an sample of white noise
            mean_noise = 0
            noise_volts = np.random.normal(mean_noise, np.sqrt(noise_avg_watts), image.shape)
            y_volts = image + noise_volts
            np.save(f'{folder_tmp}/abundance_{index}_{target_snr_db}.npy', new_arr)
            np.save(f'{folder_tmp}/image_{index}_{target_snr_db}.npy', y_volts)



def experiment3(out_root, files, wavelengths, image_path=None, reduction=2):
    """
    Function to create datasets for endmember robustness experiment

    Parameters
        out_root : str
            path to dataset out folder

        files : list
            list of material files
        
        wavelengths : numpy ndarray
            array of wavelenghts

        endmembers : list
            list of number of endmembers to use

        image_path : str
            path to ieee ground truth image .tif file

        reduction : int
            amount of times to downscale the images
    """
    exp1_out_path = os.path.join(out_root, f"exp3_{reduction}")

    if not os.path.isdir(exp1_out_path):
        os.mkdir(exp1_out_path)

    # output all of the material files, used for dataset reconstruction
    with open(os.path.join(exp1_out_path, "filelist.txt"), 'w') as fl:
        for listitem in files:
            fl.write('%s\n' % listitem)

    # output wavelenghts
    np.save(os.path.join(exp1_out_path, "WL.npy"), wavelengths)

    # read IEEE data fusion contesst image
    if image_path is None:
        image_path = settings.ieee_dataset_image

    src = rasterio.open(image_path)
    array = src.read(1)
    src.close()
    print("Reading IEEE raster file. Image size = ", array.shape)

    array = array[::reduction, ::reduction]
    endmembers = np.unique(array)

    # generate vector of endmembers
    iterations = 10
    vector = np.repeat(np.arange(min(endmembers) + 2, max(endmembers) + 2), iterations)  # from 2 to 22 (not included) endmembers 
    np.random.seed(100)
    np.random.shuffle(vector)  # to set different materials on different classes shuffle the vector data

    # generate datasets
    endm, names = getEndmemberSet(files, vector.max())
    folder_tmp = os.path.join(exp1_out_path, "dataset")
    if not os.path.isdir(folder_tmp):
        os.mkdir(folder_tmp)

    np.save(os.path.join(folder_tmp, "endmembers.npy"), endm)
    np.save(os.path.join(folder_tmp, 'filenames.npy'), np.array(names))

    for l, vec in enumerate(np.split(vector, iterations)):
        index = l
        uniform_pix = np.squeeze(createAbundance(endm, uniform=True, pixel_size = np.array([1, 1]),
                                                image_size=np.array([1, 1])))
        pixels = uniform_pix[np.newaxis, :]
        print(index)  # iteration index
        print(vec)  # generated calss to material mapping vector

        for i in vec:
            a = np.full(vector.max(), False)
            a[:i] = True
            np.random.shuffle(a)
            pix1 = np.squeeze(createAbundance(endm, uniform=False, pixel_size = np.array([1, 1]),
                                            image_size=np.array([1, 1])))
            pix1[a==False] = 0

            pix1 = pix1/np.sum(pix1)

            pixels = np.append(pixels, pix1[np.newaxis, :], axis=0)
            
        new_arr = array[:, :, np.newaxis]

        new_arr = np.repeat(new_arr, 21, axis=2)
        new_arr = new_arr.astype('float16')

        for i in range(pixels.shape[0]):
            new_arr[array == i, :] = np.squeeze(pixels[i])

        image = np.dot(new_arr, endm)
        image = image.astype('float16')

        np.save(f'{folder_tmp}/abundance_{index}.npy', np.array(new_arr))
        np.save(f'{folder_tmp}/image_{index}.npy', np.array(image))


def read_usgs(main_folder, wavelength):
    """
    Function to read usgs material and wavelength files

    Parameters
        main_folder : str
            path to folder where material .txt files are located

        wavelegnth : str
            path to wavelenght text file

    Returns
        file_paths_new : list
            list of material files
        
        wls : numpy ndarray
            array of wavelenghts
    """
    # read wavelength file to numpy array
    wls = []
    with open(wavelength, 'r') as f:
        wls = [x.strip(' ').strip("\n") for x in f.readlines()]
        wls = np.array(wls, dtype='float')

    print("Wavelenght file read, array size: ", wls.shape)
    
    # read text files
    file_paths = []
    for currentpath, folders, files in os.walk(main_folder):
        for file in files:
            file_paths.append(os.path.join(currentpath, file))
    print("Number of material files found ", len(file_paths))

    # clean files
    file_paths_new = file_paths.copy()
    for f in file_paths:
        if 'errorbars' in f:
            file_paths_new.remove(f)
            continue
        # filter files with assumed incorrect data or small values
        with open(f) as readfile:
            end = [x.strip(' ').strip("\n") for x in readfile.readlines()[1:]]
            end = np.array(end, dtype='float')
            if end[end < 0.00005].shape[0] > 10:
                file_paths_new.remove(f)
    print("Number of material files collected after filter ", len(file_paths_new))

    return file_paths_new, wls


def selectendmembers(file_list, amount, seed=10):
    # select random endmembers from file list, and set the seed for reproducibility
    random.seed(seed)
    return random.sample(file_list, amount)


def getEndmemberSet(file_list, amount):
    # get endmember collection, return file data and filenames
    endms = []
    names = []
    for file in selectendmembers(file_list, amount):
        with open(file) as f:
            end = [x.strip(' ').strip("\n") for x in f.readlines()[1:]]
            names.append(file)
            endms.append(end)
    endms = np.array(endms, dtype='float')
    endms[endms < 0.00005] = 0
    return endms, names


def minmaxscaler(v):  # numpy array minmax scaler
    return (v - v.min()) / (v.max() - v.min())


def createPixelAbundance(endmsize, threshold=0):
    abd = np.random.uniform(0, 1, endmsize)
    abd = abd/abd.sum()  # scale to sum to 1 
    abd[abd < threshold] = 0
    if abd.sum() == 0:  # if all values below threshold, lower threshold until ve get some values
        return createPixelAbundance(endmsize, threshold * 0.9)
    return abd/abd.sum()  # rescale to sum to 1 if some abds were set to 0


def createAbundance(endmembers, threshold=0.05, pixel_size=np.array([12, 12]), image_size=np.array([1, 1]), uniform=True):
    """
    Create endmember abundance matrix

    Parameters
        endmembers : numpy ndarray
            matrix of endmember data shape of [N, WL]: N - number of endmemebers, WL - wavelengths
        
        threshold : float
            minimum abundance to keep, lower than this threshold will be set to 0
        
        pixel_size : numpy ndarray
            the amount of dots (pixels) in rectangle to create for each endmember: shape [x, y]. 

        image_size : numpy ndarray
            how many times to repeat the generated image (collection of pixels for each endmember) in each axis.

        uniform : boolean
            to use uniform endmember distribution or random generation
    """
    if uniform:
        amt = endmembers.shape[0]
        abd = 1/amt
        abd_mat = np.tile(np.array(abd), (pixel_size[0]*image_size[0], pixel_size[1]*image_size[1], amt))
        return abd_mat
    else:
        num = endmembers.shape[0]
        mat = np.zeros((image_size[0]*pixel_size[0], image_size[1]*pixel_size[1], num))
        for x in range(image_size[0]):
            for y in range(image_size[1]):
                tmp = np.repeat(createPixelAbundance(num, threshold)[np.newaxis, :], pixel_size[0], axis=0)
                tmp = np.repeat(tmp[:, np.newaxis, :], pixel_size[1], axis=1)
                mat[x*pixel_size[0]:(x+1)*pixel_size[0], y*pixel_size[1]:(y+1)*pixel_size[1], :] = tmp
        return mat


def addNoise(band, snr):
    # add some noise with normal distribution
    mean_value = np.mean(band)
    mean_db = 10 * np.log10(mean_value)
    noise_db = mean_db - snr
    noise_avg = 10 ** (noise_db / 10)
    
    mean_noise = 0
    noise = np.random.normal(mean_noise, np.sqrt(noise_avg), band.shape)
    return band + noise


def main(args):
    # use settings if parameters are empty
    if args['outfolder'] is None:
        args['outfolder'] = settings.dataset_root
    if args['usgsfolder'] is None:
        args['usgsfolder'] = settings.usgs_folder
    if args['usgswavelength'] is None:
        args['usgswavelength'] = settings.usgs_wavelength
    
    files, wls = read_usgs(args['usgsfolder'], args['usgswavelength'])
    # optional 
    # experiment0(args['outfolder'], files, wls)

    experiment1(args['outfolder'], files, wls, args['ieeedataset'])

    experiment2(args['outfolder'], os.path.join(args['outfolder'], "exp1", "dataset"))

    experiment3(args['outfolder'], files, wls, args['ieeedataset'], reduction=2)
    experiment3(args['outfolder'], files, wls, args['ieeedataset'], reduction=3)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-u', '--usgsfolder', type=str, dest="usgsfolder", help="Path to USGS library folder containing. An example folder ius given, other materials can be used.")
    parser.add_argument('-w', '--usgswavelength', type=str, dest="usgswavelength", help="Path to file with USGS wavelenghts. An example wavelenght file is given, others can be used that match given material data.")
    parser.add_argument('-o', '--outfolder', type=str, dest="outfolder", help="An alternative dataset output folder")
    parser.add_argument('-i', '--ieeedataset', type=str, dest="ieeedataset", help="Path to ieee dataset file (by default used file was 2018_IEEE_GRSS_DFC_GT_TR.tif), (extracted from phase2.zip) downloaded from the link provided")
    parser.add_argument('arg', nargs='*')
    parsed = parser.parse_args()
    main(vars(parsed))