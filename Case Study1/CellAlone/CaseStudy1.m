%% IE 521 CONVEX OPTIMIZATION FINAL PROJECT CODE 
% CASE STUDY-01
%--------------------------------------------------------------------------
% CaseStudy1.m
% 
%--------------------------------------------------------------------------
% This case study minimizes the time and the power need only for machine
% cell without any disruption. 
%--------------------------------------------------------------------------
% Contributors: Satya RT Peddada (satyartpeddada) & Albert E Patterson 
% POETS, University of Illinois at Urbana-Champaign
%--------------------------------------------------------------------------
%%
% 
%   
% 

function [x,fval] = CaseStudy1(x,p)
% Parameters Constants 

p.Up = 60*10^6; % [Conversion factor]
p.D  = 100;     % [mm]  
p.d = 1;        % [mm]  
p.F1 = 20;      % [N/mm^2]
p.VR1 = 3486698;% [mm^3]
p.F2 = 35;      % [N/mm^2]
p.L1 = 60;      % [mm] 
p.theta1 = 12;  % [mm]
p.F3 = 35;      % [N/mm^2] 
p.VR2 = 668971; % [mm^3]
p.eta1 = 0.70;  % [No units]
p.theta2 = 8;   % [mm]  
p.F4 = 20;      % [N/mm^2]
p.L2 = 20;      % [mm] 
p.theta3 = 8;   % [mm]
p.F5 = 35;      % [N/mm^2]
p.VR3 = 198469; % [mm^3]
p.eta2 = 0.7;   % [No units]
p.theta4 = 8;   % [mm]
p.F6 = 20;      % [N/mm^2]
p.L3 = 30;      % [mm]
p.theta5 = 25;  % [mm]
p.F7 = 35;      % [N/mm^2]
p.L4 = 125;     % [mm]
p.F8 = 20;      % [N/mm^2]
p.wp = 600;     % [mm]
p.eta3 = 0.5;   % [No units]
p.theta6 = 50;  % [mm]
p.VR4 = 104248; % [mm^3]
p.F9 = 50;      % [N/mm^2]

p.T_max = 120; % [min]
p.P_max = 200; % [kilowatts]

% Constraints

% Lower bounds : x1 through x23 
 lb = [ 0.01       % x1 
        130        % x2  
         1         % x3  
        0.01       % x4  
        150        % x5 
        0.01       % x6 
        150        % x7
        0.01       % x8   
        130        % x9
        1          % x10
        0.01       % x11
        570        % x12
        1          % x13
        130        % x14
        1          % x15 
        0.01       % x16 
        570        % x17  
        150        % x18  
        1          % x19
        0.2        % x20
        0.001      % x21 
        0.001      % x22
        500];      % x23

% Upper bounds : x1 through x23 

ub = [3           % x1            
      2000        % x2
      5           % x3 
      1           % x4 
      2400        % x5
      2           % x6
      2400        % x7
      3           % x8
      2000        % x9
      5           % x10 
      1           % x11
      3050        % x12
      2           % x13
      2000        % x14
      5           % x15
      1           % x16 
      3050        % x17 
      2050        % x18
      100         % x19 
      1           % x20   
      0.5         % x21 
      0.1         % x22  
      20000];     % x23

% Initial starting point from x1 through x23
x0 = [1;150;2;0.5;200;0.05;200;0.05;150;2;0.5;
      600;1.2;200;2;0.05;600;180;2;0.4;0.005;0.005;501]; 

% Optimization using fmincon 
% Options for the algorithm
options = optimoptions('fmincon','Algorithm','interior-point','Display',...
 'iter','MaxFunctionEvaluations',200000 , 'MaxIterations',10000)


[x,fval,exitflag] = fmincon(@(x)objfn(x,p),x0,[],[],[],[],lb,ub,...
    @(x)nonlcon(x,p),options);  

% Printinf the results
disp('Optimal design variables (x1 to x23) xopt*:')
fprintf('%16.9f\n',x)  % xopt

disp('Optimal (T+P) --> fopt*:')
fprintf('%16.9f',fval) % fopt
end


  
  
