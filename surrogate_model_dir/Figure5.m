% This function plots vs(rvec_i,tvec) for variable observation point, fixed
% source position.
clear all;
close all;
clc;

[nodes_brain,tri]=read_tri_files('brain.tri');
[nodes_head,tri]=read_tri_files('head.tri');
clear tri;
cvec=[-0.0043    0.0169    0.0672];

Ns=size(nodes_head,1);
tdx=1000;   
tvec=nodes_brain(tdx,:)-cvec;
tvecunit=tvec./norm(tvec);
tau=norm(tvec);
for sdx=1:Ns 
    sdx
    rvec=nodes_head(sdx,:)-cvec; 
    r=norm(rvec);
    rnorm(sdx,1)=r;
    rvecunit=rvec./r;
    costh=dot(tvecunit,rvecunit);
    ang(sdx,1)= acosd(costh);
    g(sdx,1) = integral (@(y) GradVsDotTvec(y,r,costh),0,tau);
end
figure;

data=[ang rnorm g];
data=sortrows(data,1);
% indices=1:5:Ns;
% data=data(indices,:);

subplot(2,1,1);
plot(data(:,1),data(:,3),'b.-');
xlabel('Angle between the source-observation unit vectors in Degrees.');
ylabel('Vs(r,t)');
axis tight;
grid on;
title('plot of auxliary function, Vs(r,t), fixed source.');
subplot(2,1,2);
plot(data(:,1),data(:,2),'b.-');
xlabel('Angle between the source-observation unit vectors in Degrees.');
ylabel('norm[rvec] meters');
axis tight;
grid on;
title('Norm(rvec) versus [rvecunit cdot tvecunit]');

