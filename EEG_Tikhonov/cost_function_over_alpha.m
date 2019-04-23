function CostFncVal=cost_function_over_alpha(alpha,data)
 	Compute_Save_RBF_Matrices(alpha);
	load Vs.mat;
    Vs=auxiliary_function.Vs;
    clear auxiliary_function;
    N=size(Vs,2);
    Vs=Vs./N;
    load IMQ.mat IMQ;
    H=Vs*IMQ;
    alpha
    % maximization of (data'*H)*pinv(H'*H)*(H'*data); 
    % is equiavalent to minimization of (-1)*(data'*H)*pinv(H'*H)*(H'*data); 
    CostFncVal=-1.*(data'*H)*pinv(H'*H)*(H'*data);
 
 end

