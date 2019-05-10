%% IE 521 CONVEX OPTIMIZATION FINAL PROJECT CODE 
% CASE STUDY-01 NONLINEAR CONSTRAINTS
%--------------------------------------------------------------------------
% nonlcon.m
% 
%--------------------------------------------------------------------------
% This function contains the constraint functions for CaseStudy-01 without
% cell disruption.
%--------------------------------------------------------------------------
% Contributors: Satya RT Peddada (satyartpeddada) & Albert E Patterson 
% POETS, University of Illinois at Urbana-Champaign
% Project link: https://github.com/satyartpeddada/
%--------------------------------------------------------------------------

function [c,ceq] = nonlcon(x,p,w)

%% Time functions 
% Tcell is sum of t1 through t11
t1 = p.D./(x(1).*x(2)); 
t2 = (p.VR1./(6*pi.*(x(3).^2).*x(4).*x(5)));
t3 = p.L1./(x(6).*x(7)); 
t4 = (1/3).*(p.VR2)./(p.eta1.*p.theta2.*x(8).*x(9).*x(10));
t5 = (24*p.L2./(x(11).*x(12))) + 1.92;
t7 = (4*p.L3./(x(13).*x(14))) + 0.3333;
t8 = (32*p.L4./(x(15)));
t9 =(1/3).*(p.VR4.*p.wp)./((p.eta3^2)*(p.theta6^2).*x(18).*x(19).*x(20));
t10 = 31+22; % Added 22 mins here 
t11 = 1.667;



%% Power functions
% Pcell is sum of p1 through p12
p1 = pi*(p.d^2)*(p.F1)./(p.Up*(1./(x(1))).*(1./(x(2)))); 
p2 = pi*(p.F2)./(p.Up*(1./(x(3))).*(1./(x(4))).*(1./(x(5)))); 
p3 = (p.theta1^2)*(p.F3)./(240000*(1./(x(6))).*(1./(x(7)))); 
p4 = (p.eta1)*(p.theta2)*(p.F4)./(p.Up*(1./(x(8))).*(1./(x(9))).*(1./(x(10)))); 
p5 = 24*(p.theta3^2)*(p.F5)./(240000*(1./(x(11))).*(1./(x(12)))); 
p7 = 4*(p.theta5^2)*(p.F7)./(240000*(1./(x(13))).*(1./(x(14)))); 
p8 = pi*(p.F8)./(p.Up*(1./(x(15))).*x(16).*x(17)); 
p9 = (p.eta3)*(p.theta6)*(p.F9)./(p.Up*(1./(x(18))).*(1./(x(19))).*(1./(x(20)))); 
p10 = 1.8+3; % Added 3 kW here
p11 = 0.020;

% Appending the T_max and P_max constraints
c = [t1 + t2 + t3 + t4 + t5  + t7 + t8 + t9 + t10 + t11 - p.T_max + 20;     % Compute nonlinear inequalities at x.
     p1 + p2 + p3 + p4 + p5  + p7 + p8 + p9 + p10 + p11 - p.P_max + 49.5];
ceq = [];   % Compute nonlinear equalities at x.
end
