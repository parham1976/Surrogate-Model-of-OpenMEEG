%% This Matlab file plots the output of the surrogate model against the output computed by OpenMEEG for comparison purposes.
%% It is Figure 3 in the paper: "A Surrogate Model Of The Forward Problem  in EEG Imaging", P. Hashemzadeh and A.S. Fokas.
%% It generates figure 3 in the paper. 
clc;
clear all;
close all;
%% The Test data is (46885 x 4).
data = csvread('test_data.csv');

%%                                 Inputs to the Surrogate Model
Inputs=data(:,1:3)';  % For some reason data into pSeven Surrogate Model needs to be fed in 3xN 
%%
F_OpenMEEG=data(:,4); % This is Gradient Vs(rvec,tvec) dot tvecunit computed by OpenMEEG, considered as truth values.
%% surrogate_model(inputs) is the pSeven HDA.
F_Surrogate=surrogate_model(Inputs)'; % For some reason the response from pSeven is returned as 1xN, so transpose.
%%                             Root Mean Square Error
RMSE=sqrt(mean(abs(F_OpenMEEG-F_Surrogate).^2)); % Compute The RMSE.
tit1=strcat('(a) RMSE=',num2str(RMSE));
tit2=strcat('(b) RMSE=',num2str(RMSE));
% Plot only 1000 points out of Ns test points. 
Ns=1000;

subplot(2,1,1);
plot(F_OpenMEEG(1:Ns),'bx-');
hold on;
plot(F_Surrogate(1:Ns),'ro-');
Error=abs(F_OpenMEEG(1:Ns)-F_Surrogate(1:Ns));
axis tight;
grid on;
xlabel('Input sample Indices');
ylabel('Electric Potential (Volts)');
legend('Solution of OpenMEEG', 'Surrogate Model');
title(tit1);
axis tight;

subplot(2,1,2);
plot(Error,'b.-');
axis tight;
grid on;
title('Absolute Error');
ylabel('Absolue Error');
xlabel('Input sample Indices');
title(tit2)