% This script is the first script to be run.
% It will setup a Uniform Cartesian Grid Inside The Cerebrum.
% It will Solve the Auxiliary function using the Surrogate Model and Save
% it.
% of https://github.com/parham1976/Surrogate-Model-of-OpenMEEG/tree/master/surrogate_model_dir
clear all;     % Clear The Work Space.
close all;     % Close All Figures.
clc;           % Clear the Work space screen.
%% Read The Current Path and Add the Surrogate Model Path Needed For The Auxiliary Functions to it.
current_dir=pwd;  % current path
dirname=strcat(current_dir,'/surrogate_model_dir'); %surrogate model of openMEEG, and vs(\rvec,\tvec).
addpath(dirname);% add path

headmodel_filename='headmodel.mat';
Nump_pnts_cartesian_grid=20; % Number of points in the x,y,z direction.
%This function setups the Cartesian Grid inside the cerebrum.
Setup_Cartesian_Grid(Nump_pnts_cartesian_grid,headmodel_filename); 
VsFilename='Vs.mat'; % auxiliary function values.
Compute_Save_Auxiliary_Function(headmodel_filename,VsFilename);
%% The motivation of the steps that follow is to vectorize RBFs calculations.
%  RBF nodes do not change. So, by pre-calculating and saving them, you
%  save a lot of time. Again, this is A ONE TIME INVESTMENT.
load(headmodel_filename);
pnts=headmodel.cartesian_grid;
Compute_Distance_Matrix(pnts);
%% Now, everything is ready for estimation. YOU DO NOT NEED TO RUN THIS FILE AGAIN.
fprintf('Now Run Figure2_3.m\n');