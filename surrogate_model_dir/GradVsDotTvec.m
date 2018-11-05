function dvsf_dn=GradVsDotTvec(tau,r,cos_th)
  %Inputs 
  %tau    : radial distance to source
  %X.r=r  : radial distance to observation
  %X.tvec_dot_rvec : cosine of the angle between source and observation.
  %ouputs
  %dvsf_dn
  Inputs(1)=r;
  Inputs(3)=cos_th;
  for jdx=1:length(tau)
    Inputs(2)=tau(jdx);
    dvsf_dn(jdx)=surrogate_model(Inputs')';
  end 
end