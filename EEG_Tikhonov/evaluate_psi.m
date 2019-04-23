function [psi,lappsi]=evaluate_psi(alphavec,betavec)
 % This function computes Psi, for generating synthetic Psi.
 load headmodel.mat;
 pnts=headmodel.cartesian_grid;
 Np=size(pnts,1);
 indices=[1 500 2000 3000];  %These nodes are abitrary indices for sources.
 x1=pnts(indices(1),:);
 x2=pnts(indices(2),:);
 x3=pnts(indices(3),:);
 x4=pnts(indices(4),:);

 for jdx=1:Np
         xj=pnts(jdx,:);        
         dist(1)=norm(xj-x1)^2;
         dist(2)=norm(xj-x2)^2;
         dist(3)=norm(xj-x3)^2;
         dist(4)=norm(xj-x4)^2;
         
         term(1)=alphavec(1)*exp(-1*betavec(1)*dist(1));    
         term(2)=alphavec(2)*exp(-1*betavec(2)*dist(2));
         term(3)=alphavec(3)*exp(-1*betavec(3)*dist(3));    
         term(4)=alphavec(4)*exp(-1*betavec(4)*dist(4));
         psi(jdx,1)=sum(term);
         clear term;
         for kdx=1:4
          term(kdx)=2*exp(-1*betavec(kdx)*dist(kdx))*alphavec(kdx)*betavec(kdx)*(-3+2*dist(kdx)*betavec(kdx));
         end 
        lappsi(jdx,1)=sum(term);
        clear term;
         
 end    
  psi=psi-mean(psi);
  lappsi=lappsi-mean(lappsi);
  save psi_temp.mat psi lappsi; % It saves Psi and the Laplacian.
end