%% IISE 2020 Conference Paper 
% %--------------------------------------------------------------------------
% CaseStudy1_Pareto.m
% %--------------------------------------------------------------------------
% original Cell: This case study minimizes the time and the power need only for machine
% cell without disruption and plots the pareto front. 
%--------------------------------------------------------------------------
% Contributors: Satya RT Peddada (github: satyartpeddada) & Albert E. Patterson 
% Department of ISE, University of Illinois at Urbana-Champaign
%--------------------------------------------------------------------------
%%

function [x,fval] = CaseStudy1_Pareto(x,p)
% Constant Paramters
p.Up = 60*10^6; % [Conversion factor]
p.D  = 12;      % mm  
p.V1 = 114000;  % mm^3   % This will change t0 114000 for disrupted cell
p.V2 = 9468000; % mm^3
p.V5 = 43400;   % mm^3
p.Fc1 = 50;     % N/mm^2
p.Fc2 = 50;     % N/mm^2 
p.Fc3 = 50;     % N/mm^2
p.Fc4 = 50;     % N/mm^2
p.Fc5 = 50;     % N/mm^2
p.eta1 = 0.7;   % unitless
p.eta2 = 0.7;   % unitless
p.theta1 = 6;   % mm
p.theta2 = 8;   % mm
p.theta3 = 12;  % mm
p.theta4 = 12;  % mm
p.H1 = 7;       % count
p.H2 = 1;       % count
p.Ld1 = 35;     % mm
p.Ld2 = 150;    % mm
p.tm1 = 0.25;   % min
p.tm2 = 0.25;   % min
p.TP = 1.75;    % mm
p.Ltap  = 35;   % mm


% Max Time constraint
p.T_max = 200;  % min

% Max Power constraint
p.P_max = 100;  % KW

%% Design Variable bounds

% Lower bounds : x1 through x12 
 lb = [0.01            
     130
     1
     0.1
     130
     1
     0.01
     400
     0.01
     100
     0.01
     150
     ];

% Upper bounds : x1 through x12 

ub = [2
    1000
    5
    3
    1000
    10
    1
    1200
    1
    500
    1
    1400
    ];

% Initial design points
x0 = [0.05
    150
    2
    0.5
    150
    2
    0.05
    600
    0.05
    200
    0.5
    200
    ];


%% Optimization algorithm using fmincon 

% Options for the algorithm
options = optimoptions('fmincon','Algorithm','interior-point',...
 'MaxFunctionEvaluations',200000 , 'MaxIterations',10000);

% Pareto plot steps
a = 0:(1/2000):1;

% Design vector initialization
x = zeros(length(a),12);
o1 = zeros(length(a),1);
o2 = zeros(length(a),1);

for idx = 1:length(a)
    w = a(idx);
    [xtmp,fval,exitflag,output] = fmincon(@(x)objfn(x,p,w),x0,[],[],[],[],lb,ub,...
        @(x)nonlcon(x,p,w),options);
    x(idx,:) = reshape(xtmp, 1, numel(xtmp));
    [~,o1tmp,o2tmp] = objfn(xtmp,p,w);
    o1(idx,1) = o1tmp;
    o2(idx,1) = o2tmp;
end

%Pareto plot for original cell
figure;
hold on
plot(o1,o2,'b.','MarkerSize',12);
xlabel('Time (min)');
ylabel('Power[kW]');
title('Pareto- Time vs. Power for Machine Cell w/o Disruption')
save('original','o1','o2');

%% OUTPUT VALUES REQUIRED FOR THE PAPER
% Printing the results [OPTIONAL]
disp('Optimal design variables (x1 to x12) xopt*:')
fprintf('%16.9f\n',xtmp)  % xopt

disp('Optimal (T+P) --> fopt*:')
fprintf('%16.9f\n',fval) % fopt

disp('Exitflag')
fprintf('%16.9f\n',exitflag) %exitflag

disp('Output') % fmincon properties output
output

disp('Optimized Original Cell Time:')  % Final optimal Tcell value
fprintf('%16.9f\n',o1(end)) 

disp('Optimized Original Cell Power:') % Final optimal Pcell value
fprintf('%16.9f\n',o2(end)) 
end



  
