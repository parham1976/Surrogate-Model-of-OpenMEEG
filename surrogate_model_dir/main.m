%% This file is the main program for testing the constructed surrogate model.
clc;
clear all;
close all;
data = csvread('test_data.csv');
Inputs=data(:,1:3)';  % For some reason data into pSeven Surrogate Model needs to be fed in 3xN 
F_OpenMEEG=data(:,4); % This is Gradient Vs(rvec,tvec) dot tvecunit computed by OpenMEEG (truth values)

F_Surrogate=surrogate_model(Inputs)'; % For some reason the response from pSeven is returned as 1xN, so transpose.

RMSE=sqrt(mean(abs(F_OpenMEEG-F_Surrogate).^2));
fprintf('RMSE=%7.6f',RMSE);
% Plot only 1000 points out of N test points. 
N=1000;
plot(F_OpenMEEG(1:N),'bx-');
hold on;
plot(F_Surrogate(1:N),'ro-');
axis tight;
grid on;
xlabel('Sample indices');
ylabel('Electric Potential (Volts)');
legend('OpenMEEG', 'Surrogate Model');
centroid=[-0.0043    0.0169    0.0672];

[nodes,tri]=read_tri_files('brain.tri');
eeg_elec=load('eeg_channels_locations.txt');
idx=1500;
sdx=110;
tvec=nodes(idx,:)-centroid;
rvec=eeg_elec(sdx,:)-centroid;
rvecunit=rvec./norm(rvec);
r=norm(rvec);
tau_max=norm(tvec);
tvecunit=tvec./norm(tvec);
costh=dot(tvecunit,rvecunit);
tau_vec=linspace(0,tau_max,10000);
Ns=length(tau_vec);
for idx=1:Ns
    tau=tau_vec(idx);
    X=[r tau costh];
    vs(idx,1)=surrogate_model(X')*tau_max/Ns;
end
figure;
plot(tau_vec,cumsum(vs),'b.-');
axis tight;
grid on;