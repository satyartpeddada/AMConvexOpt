%% IE 521 Convex Optimization 
% CASE STUDY-01 % DISRUPTED CELL LAYOUT
%--------------------------------------------------------------------------
% CaseStudy1_Disrupted.m
% 
%--------------------------------------------------------------------------
% This case study minimizes the time and the power need only for machine
% cell with disruption due to addition of a 3D printer. The starting point
% for this code is the optimum design variables 
%--------------------------------------------------------------------------
% Contributors: Satya RT Peddada (satyartpeddada) & Albert E Patterson 
% POETS, University of Illinois at Urbana-Champaign
% Project link: https://github.com/satyartpeddada/
%--------------------------------------------------------------------------
function [x,fval] = CaseStudy1_Disrupted_Pareto(x,p)
% Parameters Constants

p.Up = 60*10^6; % [Conversion factor]
p.D  = 100;     % mm  
p.d = 1;
p.F1 = 20;
p.VR1 = 3906827; % 3486698;
p.F2 = 35;
p.L1 = 60;
p.theta1 = 12;
p.F3 = 35; 
p.VR2 = 668971;
p.eta1 = 0.70;
p.theta2 = 8;
p.F4 = 20;
p.L2 = 20;
p.theta3 = 8;
p.F5 = 35;
p.L3 = 30;
p.theta5 = 25;
p.F7 = 35;
p.L4 = 125;
p.F8=20;
p.wp = 600;
p.eta3 = 0.5;
p.theta6 = 50;
p.VR4 = 104248;
p.F9 = 50; 

p.T_max = 120;
p.P_max = 200;

% Constraints

% Lower bounds : x1 through x20 
 lb = [ 0.01
        130
        1
        0.01
        150
        0.01
        150
        0.01
        130
        1
        0.01
        570
        0.01
        570
        150
        1
        0.2
        0.001
        0.001
        500];

% Upper bounds : x1 through x20 

ub = [3 
      2000
      5
      1
      2400
      2
      2400
      3
      2000
      5
      1
      3050
      1
      3050
      2050
      100
      1
      0.5
      0.1
      20000];

%  x0 = [1;150;2;0.5;200;0.05;200;0.05;150;2;0.5;600;0.05;600;180;2;0.4;0.005;0.005;501]; 
x0 = [2.999907559
  1999.938372006
     4.999999740
     0.999999895
  2399.999749096
     0.079206841
   674.849481181
     2.999999245
  1999.999496588
     4.999998741
     0.065141811
   710.623621246
     0.025636466
   707.675878477
  2049.999663796
    98.586408121
     0.985946192
     0.499999995
     0.099999999
 19999.999808030];
% Optimization using fmincon 
options =  optimoptions('fmincon', 'MaxFunctionEvaluations', 200000 , 'MaxIterations',10000  )
%[x,fval,exitflag] = fmincon(@(x)objfn(x,p),x0,[],[],[],[],lb,ub,@(x)nonlcon(x,p),options)  

% fprintf('%16.9f\n',x) 
% fval
% fprintf('%16.9f',fval) 

a = 0:(1/2000):1;
% counter
x = zeros(length(a),20);
o1_disrupt = zeros(length(a),1);
o2_disrupt = zeros(length(a),1);
for idx = 1:length(a)
    w = a(idx);
    [xtmp,fval,exitflag] = fmincon(@(x)objfn(x,p,w),x0,[],[],[],[],lb,ub,...
        @(x)nonlcon(x,p,w),options);
    x(idx,:) = reshape(xtmp, 1, numel(xtmp));
    [~,o1tmp,o2tmp] = objfn(xtmp,p,w);
    o1_disrupt(idx,1) = o1tmp;
    o2_disrupt(idx,1) = o2tmp;
end
figure;
hold on
plot(o1_disrupt,o2_disrupt,'b.','MarkerSize',12);
xlabel('Time (min)');
ylabel('Power[kW]');
title('Pareto - Time vs. Power for Machine Cell with AM Disruption')
save('distrupted','o1_disrupt','o2_disrupt');

end


  



  
