function Compute_Save_RBF_Matrices(alpha)
     load distance_matrix.mat dist;
     MQ=sqrt(alpha*alpha+dist);
     IMQ=1./MQ;
     save IMQ.mat IMQ;
     clear IMQ;
     Den=MQ.^5;
     LapMQ=-3*alpha*alpha./Den;
     save LapMQ.mat LapMQ;
     load Ax.mat Ax;
     Dx=-1.*Ax./(MQ.^3);
     save Dx.mat Dx;
     clear Dx;
     clear Ax;
     
     load Ay.mat Ay;
     Dy=-1.*Ay./(MQ.^3);
     save Dy.mat Dy;
     clear Dy;
     clear Ay;
     
     load Az.mat Az;
     Dz=-1.*Az./(MQ.^3);
     save Dz.mat Dz;
     clear Dz;
     clear Az;
     
     
     
 end
