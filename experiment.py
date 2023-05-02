import numpy as np
from sklearn.metrics import mean_squared_error, make_scorer
from sklearn.model_selection import ParameterGrid, KFold
from sklearn.base import BaseEstimator
import multiprocessing
from functools import partial
import os
import csv
import json
import ast


def endmember_list():
    v1 = np.arange(3, 10, 1)
    v2 = np.arange(10, 30, 5)
    v3 = np.arange(30, 110, 10)
    endms = np.hstack((v1, v2, v3))
    return endms


class Experiment():
    
    def __init__(self, algorithm, dataset_folder="/home/vytas/SynologyDrive/Doktorantura/datasets/USGSD2",
                result_folder = "/home/vytas/SynologyDrive/Doktorantura/Results/Experiment1"):
        self.dataset_folder = dataset_folder
        self.result_folder = result_folder
        self.algorithm = algorithm
        self.result_path = os.path.join(self.result_folder, algorithm)
        
    def get_dataset(self, endmembers, image_num, uniform=False, basepath="dataset_"):
        self.basepath = basepath
        self.num_endmembers = endmembers
        self.folder = os.path.join(self.dataset_folder, basepath+str(endmembers))
        if uniform:
            image_num = "uniform"
        self.image_num = image_num
    
    def read_dataset(self, abd="abundance_", img="image_", endm="endmembers", files="filenames"):
        self.abundance_mat = np.load(os.path.join(self.folder, abd+str(self.image_num)+".npy"))
        self.image = np.load(os.path.join(self.folder, img+str(self.image_num)+".npy"))
        self.endmember_mat = np.load(os.path.join(self.folder, endm+".npy"))
        self.files = np.load(os.path.join(self.folder, files+".npy"))
        
    def read_pattern_dataset(self, abd="abundance", img="image", endm="endmembers", files="filenames", index=None, ignore_abd_index=False, index2=None):
        if index is None:
            self.abundance_mat = np.load(os.path.join(self.folder, abd+".npy"))
            self.image = np.load(os.path.join(self.folder, img+".npy"))
            self.endmember_mat = np.load(os.path.join(self.folder, endm+".npy"))
            self.files = np.load(os.path.join(self.folder, files+".npy"))
        else:
            if index2 is None:
                self.abundance_mat = np.load(os.path.join(self.folder, abd+"_"+index+".npy"))
                self.image = np.load(os.path.join(self.folder, img+"_"+index+".npy"))
                if ignore_abd_index:
                    self.endmember_mat = np.load(os.path.join(self.folder, endm+".npy"))
                    self.files = np.load(os.path.join(self.folder, files+".npy"))
                else:
                    self.endmember_mat = np.load(os.path.join(self.folder, endm+"_"+index+".npy"))
                    self.files = np.load(os.path.join(self.folder, files+"_"+index+".npy"))
            else:
                self.abundance_mat = np.load(os.path.join(self.folder, abd+"_"+index2+"_"+index+".npy"))
                self.image = np.load(os.path.join(self.folder, img+"_"+index2+"_"+index+".npy"))
                if ignore_abd_index:
                    self.endmember_mat = np.load(os.path.join(self.folder, endm+"_"+index2+".npy"))
                    self.files = np.load(os.path.join(self.folder, files+"_"+index2+".npy"))
                else:
                    self.endmember_mat = np.load(os.path.join(self.folder, endm+"_"+index+".npy"))
                    self.files = np.load(os.path.join(self.folder, files+"_"+index+".npy"))
        
        
    def prepare_result(self, run=1):
        tmp_array = np.array([0])
        np.save(os.path.join(self.result_path, f'D{self.num_endmembers}-I{self.image_num}-R{run}-res.npy'), tmp_array)
        
    def get_result_path(self, run=1):
        return os.path.join(self.result_path, f'D{self.num_endmembers}-I{self.image_num}-R{run}-')
        
    def check_for_result(self, run=1):
        return os.path.exists(os.path.join(self.result_path, f'D{self.num_endmembers}-I{self.image_num}-R{run}-res.npy'))
    
    @staticmethod
    def SRE(true, pred):
        sre = np.linalg.norm(true)/np.linalg.norm(true-pred)
        return 10*np.log10(sre)
