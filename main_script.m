%% ECON 493 deliveriable
% Author: Larry Li
% Time: 4/29/2020

clear all; close all; clc
t = readtable("data_organized.csv"); % daily return file with 
t = readtable("data_organized(monthly).xlsx");
%% preamble

equity = [t.Cnsmr t.HiTec t.Hlth t.Manuf t.Other];
fx = [t.x1Mo t.x3Mo t.x6Mo t.x1Yr t.x2Yr t.x3Yr t.x5Yr t.x7Yr t.x10Yr t.x20Yr t.x30Yr];
fxName = ["1mo", "3mo" , "6mo", "1yr", "2yr", "3yr", "5yr", "7yr", "10yr", "20yr", "30yr"];
equityName = ["cnsmr", "hitec", "Hlth", "Manuf", "Other"];

%% unconditional correlation table

t_unconditional = unconditionalCorr(equity, equityName, fx, fxName);
t_unconditional_monthly = unconditionalCorr(equity, equityName, fx, fxName);
%% conditional rolling correlation

t_20 = conditionalCorr(equity, equityName, fx, fxName, 20, t.Date);
t_60 = conditionalCorr(equity, equityName, fx, fxName, 60, t.Date);
t_100 = conditionalCorr(equity, equityName, fx, fxName, 100, t.Date);

%% output to file
writetable(t_unconditional);
writetable(t_unconditional_monthly);

writetable(t_20);
writetable(t_60);
writetable(t_100);

