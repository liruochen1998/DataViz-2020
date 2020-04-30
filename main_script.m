%% ECON 493 deliveriable
% Author: Larry Li
% Time: 4/29/2020

%% cleaning
clear all; close all; clc

%% import data
% data have format rows are time growing from old to new, colums are
% bond/equity names, more data sample available upon request
t = readtable("data_organized.csv"); % daily return file with 
%t = readtable("data_organized(monthly).xlsx");
%% preamble

% organize the data to required format. 
equity = [t.Cnsmr t.HiTec t.Hlth t.Manuf t.Other]; % extract equities from table 
equityName = ["cnsmr", "hitec", "Hlth", "Manuf", "Other"]; % equity names
fx = [t.x1Mo t.x3Mo t.x6Mo t.x1Yr t.x2Yr t.x3Yr t.x5Yr t.x7Yr t.x10Yr t.x20Yr t.x30Yr]; % extract bonds from table
fxName = ["1mo", "3mo" , "6mo", "1yr", "2yr", "3yr", "5yr", "7yr", "10yr", "20yr", "30yr"]; %  bonds names


%% unconditional correlation table
% follow funcitonal programming scheme here, providing functions to
% calculate (un)conditional correlation between these two groups. Thus, for
% extensions, users only need to change the data set and the preamble
% above.
t_unconditional = unconditionalCorr(equity, equityName, fx, fxName);
%t_unconditional_monthly = unconditionalCorr(equity, equityName, fx, fxName);
%% conditional rolling correlation

% follow funcitonal programming scheme here, providing functions to
% calculate (un)conditional correlation between these two groups. Thus, for
% extensions, users only need to change the data set and the preamble
% above.
t_20 = conditionalCorr(equity, equityName, fx, fxName, 20, t.Date); %rolling window size 20
t_60 = conditionalCorr(equity, equityName, fx, fxName, 60, t.Date); %rolling window size 60
t_100 = conditionalCorr(equity, equityName, fx, fxName, 100, t.Date); %rolling window size 100

%Note: all the table returned from the function are well-annoted tables
%that are ready to output to csv/txt directly. They are in long format (stacked) that
%Power BI requires.
%% output to file

% output to .txt file that Power BI will queries
%{
writetable(t_unconditional);
writetable(t_unconditional_monthly);

writetable(t_20);
writetable(t_60);
writetable(t_100);
%}
