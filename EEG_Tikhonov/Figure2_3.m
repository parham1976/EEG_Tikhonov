clear all;
close all;
clc;
current_dir=pwd;
dirname=strcat(current_dir,'/fieldtrip_package_plotting');
addpath(dirname);

warning off;
cvec=[-0.0043    0.0169    0.0672]; % Center of the Head Model.

headmodelname='headmodel.mat';
load(headmodelname);
VsFilename='Vs.mat';
load(VsFilename);
Vs=auxiliary_function.Vs;
[M,N]=size(Vs);
Vs=Vs./N;
alphavec=[2 -2 2 -2];
betavec=[1e3 1e3 1e3 1e3];
[psi,lappsi]=evaluate_psi(alphavec,betavec);
data=Vs*lappsi; % Generate Data;
%%                Grid Search for optimal shape paramter
alpha_optimal = fminbnd(@(c) cost_function_over_alpha(c,data),.0001,0.04);
%%
%% Compute RBF matrices searching for the optimal shape value
%alpha_optimal=0.0154;  % Here, we have already done grid search and optimal shape parameter is alpha_optimal=0.0154.
Compute_Save_RBF_Matrices(alpha_optimal) 
%%  Estimate Laplacian of Psi(tvec) include it as prior in the reconstruction.
 load IMQ.mat IMQ;
 A=IMQ;  % Inverse Multiquadric RBF Matrix.
 clear IMQ; 
 H=Vs*A;
 betaest=pinv(H)*data;
 Lappsi=A*betaest;
 %% Clear Memory to free up space.
 clear H; clear A;
%%  Construct Main Inversion Matrix and Estimate Psi.
  load LapMQ.mat LapMQ;
  L=LapMQ; % Laplacian Operator for the Inverse Multiquadric.
  clear LapMQ;
  load Dx.mat
  load Dy.mat Dy;
  load Dz.mat Dz;
  Hmtilde=[Vs*L;L;Dx;Dy;Dz];  % This is the main Inversion Matrix Construct MAIN INVERSION MATRIX.

   %% Clear Memory to free up space.
  clear Dx; clear Dy;clear Dz;
  clear L;
  %%
  zv=zeros(N,1); % Zero Vector.
  bvec=[data;Lappsi;zv;zv;zv];  % RIGHT HAND SIDE, DATA AND GIVENs.
  lambda_vec_est=Hmtilde\bvec;          %lambdavector
  load IMQ.mat IMQ;
  A=IMQ;   % Inverse Multiquadric RBF Matrix.
  clear IMQ;
  psiest=A*lambda_vec_est;
  %% These Matrices are Big, Clear Memory to free up space.
  clear A; clear zv; clear bvec;clear Hmtilde;
  
%%  Normalize Psi and Psiest First, then Plot in 2D and 3D using Fieldtrip package routines.
 psi=psi./max(abs(psi));
 psiest=psiest-mean(psiest);
 psiest=psiest./max(abs(psiest));
 plot(psi,'b.-');
 hold on;
 plot(psiest,'ro--');
 RMSE=sqrt(sum((psi-psiest).^2)/N);
 rmse_str=num2str(RMSE);
 legend('Exact','Reconstruction');
 xlabel('Internal Node Indices in The Cerebrum');
 ylabel('Psi(tvec)');
 axis tight;
 grid on;
 tit=strcat('Comparison of exact and reconstructed Psi(tvec), RMSE=',rmse_str);
 title(tit);
 
 
 %% Plot The reconstructions on the SURFACE of Cerebrum, i.e, S_c.
 % One must interpolate the exact & estimated onto the nodes of vertices.
 
 load headmodel.mat;
 pnts=headmodel.cartesian_grid;
 F1=scatteredInterpolant(pnts(:,1),pnts(:,2),pnts(:,3),psi);
 F2=scatteredInterpolant(pnts(:,1),pnts(:,2),pnts(:,3),psiest);
 vertices=headmodel.vertices;
 bnd.pnt=vertices;
 bnd.tri=headmodel.tri;
 figure
 AZ1=-72;AZ2=88;
 EL1=51; EL2=27;
 psis=F1(vertices(:,1),vertices(:,2),vertices(:,3));
 psiests=F2(vertices(:,1),vertices(:,2),vertices(:,3));
 

 
 subplot(2,2,1);
 ft_plot_mesh(bnd,'vertexcolor',psis);
 view([AZ1,EL1]);
 colorbar;
 title('(a) Exact')
 subplot(2,2,2);
 ft_plot_mesh(bnd,'vertexcolor',psis);
 view([AZ2,EL2]);
 colorbar;
 title('(b) Exact')
 
 
 subplot(2,2,3);
 ft_plot_mesh(bnd,'vertexcolor',psiests);
 view([AZ1,EL1]);
 title('(c) Reconstruction');
 colorbar;  
 subplot(2,2,4);
 ft_plot_mesh(bnd,'vertexcolor',psiests);
 view([AZ2,EL2]);
 title('(d) Reconstruction');
 colorbar;
 
 
 
