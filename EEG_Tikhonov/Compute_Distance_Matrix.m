function Compute_Distance_Matrix(pnts)
N=size(pnts,1);
fprintf('Calculating the distance matrix...\n');
fprintf('They are needed for vectorizing shape estimation (speeding things up A LOT!!!)\n');
for idx=1:N
    tvec_i=pnts(idx,:);
    for jdx=1:N
        tvec_j=pnts(jdx,:);
        dist(idx,jdx)=norm(tvec_i-tvec_j)^2;
        difference=tvec_i-tvec_j;
        Ax(idx,jdx)=difference(1);
        Ay(idx,jdx)=difference(2);
        Az(idx,jdx)=difference(3);
      
    end
end
save distance_matrix.mat dist;
clear dist;
save Ax.mat Ax;
clear Ax;
save Ay.mat Ay;
clear Ay;
save Az.mat Az;
clear Az;
end               
