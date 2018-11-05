% This function plots vs(rvec_i,tvec) for variable observation point, fixed
% source.
clear all;
close all;
clc;

[nodes_brain,tri]=read_tri_files('brain.tri'); % Load the source position vectors.
[nodes_head,tri]=read_tri_files('head.tri');   % Load the observation position vectors.
clear tri;
cvec=[-0.0043    0.0169    0.0672];            % centroid. 
Ns=size(nodes_head,1); %% Number of Sensors.
% This table can help find sensors, which are far away from each other.
 idx=1;
 rvec_i=nodes_head(idx,:)-cvec;
 rvec_i=rvec_i./norm(rvec_i);
 for jdx=1:Ns
        rvec_j=nodes_head(jdx,:)-cvec;
        rvec_j=rvec_j./norm(rvec_j);
        cosine_table(jdx)=dot(rvec_i,rvec_j);
 end

sensor_indices=find(abs(cosine_table)<0.001);
sensor_indices=[1 sensor_indices];
sensor_positions=nodes_head(sensor_indices,:);
clear cosine_table;
M=size(sensor_positions,1);
% Select a node on the brain, we plot t in the interval [0,tau]
tdx=1;
tvec=nodes_brain(tdx,:)-cvec;
tvecunit=tvec./norm(tvec);
tau_max=norm(tvec);
Nsamples=1000;
tau_vec=linspace(0,tau_max,Nsamples);
for mdx=1:M
    rvec=sensor_positions(mdx,:)-cvec;
    r=norm(rvec);
    rvecunit=rvec./norm(rvec);
    costh=dot(rvecunit,tvecunit)
    for idx=1:Nsamples
       tau=tau_vec(idx);
       g(mdx,idx)= integral (@(y) GradVsDotTvec(y,r,costh),0,tau);  % Numerical Integration.
        
    end
    
end

plot(tau_vec,g(1,:),'b.-');
hold on;
plot(tau_vec,g(2,:),'k.-');
hold on;
plot(tau_vec,g(3,:),'r.-');
axis tight;
grid on;
xlabel('tau (meters)');
ylabel('auxiliary function Vs(r,tau)');
title('Vs(r,tau) as a function of tau, for three sensor positions, for a fixed source.');
sensor_positions=sensor_positions-cvec
leg1=strcat('rvec(',num2str(sensor_indices(1)),')');
leg2=strcat('rvec(',num2str(sensor_indices(2)),')');
leg3=strcat('rvec(',num2str(sensor_indices(3)),')');
legend(leg1,leg2,leg3);


