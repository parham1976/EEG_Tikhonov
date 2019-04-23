function Compute_Save_Auxiliary_Function(headmodel_filename,VsFilename)
    % This script computes the auxiliary function Vs(r,t).
    fprintf('Computing The auxiliary function Vs(r,t)..., Please Wait !!!\n');
    fprintf('These Computations can be long and take several hours. \n');
    fprintf('However, you only need to do them one time, JUST ONCE AND IT will be stored !!!!!!\n');
    current_dir=pwd;
    dirname=strcat(current_dir,'/surrogate_model_dir');
    addpath(dirname);
    eeg_elec=load('eeg_channels_locations.txt');
    load(headmodel_filename);
    cvec=headmodel.center;
    nodes=headmodel.cartesian_grid;
    Npnts=size(nodes,1);
    Num_Sensors=size(eeg_elec,1);   
    for mdx=1:Num_Sensors
        rvec=eeg_elec(mdx,:)-cvec;
        r=norm(rvec);
        rvecunit=rvec./norm(rvec);
        for tdx=1:Npnts
              tvec=nodes(tdx,:)-cvec;
              tvecunit=tvec./norm(tvec);
              costh=dot(rvecunit,tvecunit);
              tau=norm(tvec);
              Vs(mdx,tdx)= integral (@(y) GradVsDotTvec(y,r,costh),0,tau);  % Numerical Integration.
        end   
    end
    auxiliary_function.sensors=eeg_elec;
    auxiliary_function.nodes=nodes;
    auxiliary_function.Vs=Vs;
    save(VsFilename,'auxiliary_function');
    fprintf('Auxiliary Function Computations are Finished and saved...\n');
end   