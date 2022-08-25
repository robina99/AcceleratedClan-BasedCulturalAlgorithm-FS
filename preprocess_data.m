%
%File name: preprocess_data.m
%
%
% Programmed by Robina Rasanga
% 
% Copyright (c) 2022 Robina Rasanga<robinarasanga@students.uonbi.ac.ke>.
%
% 
% Script to process the datasets to be used. 
% This script is called at the start of the program. 
%  All data preprocessing is performed here before the CCA algorithm starts
%
% 
% As a sample, the MATLAB humanactivity sample dataset is used.  


%% load the data
load humanactivity.mat; 
X = feat;
T = actid;
% remove all unnecessary data variables
clearvars featlabels feat Description actnames actid;

