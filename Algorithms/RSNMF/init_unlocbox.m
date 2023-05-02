function init_unlocbox()
% INIT_TOOLBOX Initialize the toolbox
%

%% Initialisation script for the convex optimization problems toolbox
%
%
% 
% Author: Nathanael Perraudin
% E-mail: nathanael.perraudin@epfl.ch
% Date: july 16 2012


%% adding dependency
global GLOBAL_path;
GLOBAL_path = fileparts(mfilename('fullpath'));

addpath(genpath(GLOBAL_path));


