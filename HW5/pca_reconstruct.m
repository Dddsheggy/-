function recon_data = pca_reconstruct(pcs,cprs_data,cprs_c)
tmp=pcs*cprs_data;
n=size(cprs_c,2);
for i=1:n
    recon_data(i,:)=tmp(i,:).*cprs_c(2,i)+cprs_c(1,i);
end
end

