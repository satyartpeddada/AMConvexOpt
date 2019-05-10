%% IE 521 CONVEX OPTIMIZATION FINAL PROJECT CODE 
%  CASE STUDY-01
%--------------------------------------------------------------------------
% nonlcon.m
% 
%--------------------------------------------------------------------------
% This function ddefines the constraints for the case study minimizes the 
% time and the power need only for machine cell without any disruption. 
%--------------------------------------------------------------------------
% Contributors: Satya RT Peddada (satyartpeddada) & Albert E Patterson 
% POETS, University of Illinois at Urbana-Champaign

function [c,ceq] = nonlcon(x,p)

%% Time functions 
% Tcell is sum of t1 through t11

t1 = p.D./(x(1).*x(2)); 
t2 = (p.VR1./(6*pi.*(x(3).^2).*x(4).*x(5)));
t3 = p.L1./(x(6).*x(7)); 
t4 = (1/3).*(p.VR2)./(p.eta1.*p.theta2.*x(8).*x(9).*x(10));
t5 = (24*p.L2./(x(11).*x(12))) + 1.92;
t6 = p.VR3/(p.eta2.*p.theta4.*x(13).*x(14).*x(15));
t7 = (4*p.L3./(x(16).*x(17))) + 0.3333;
t8 = (32*p.L4./(x(18)));
t9 = (1/3).*(p.VR4.*p.wp)./((p.eta3^2)*(p.theta6^2).*x(21).*x(22).*x(23));
t10 = 31;
t11 = 1.667; 

%% Power functions
% Pcell is sum of p1 through p12
p1 = pi*(p.d^2)*(p.F1)./(p.Up*(1./(x(1))).*(1./(x(2)))); 
p2 = pi*(p.F2)./(p.Up*(1./(x(3))).*(1./(x(4))).*(1./(x(5)))); 
p3 = (p.theta1^2)*(p.F3)./(240000*(1./(x(6))).*(1./(x(7)))); 
p4 = (p.eta1)*(p.theta2)*(p.F4)./(p.Up*(1./(x(8))).*(1./(x(9))).*(1./(x(10)))); 
p5 = 24*(p.theta3^2)*(p.F5)./(240000*(1./(x(11))).*(1./(x(12)))); 
p6 = (p.eta2)*(p.theta4)*(p.F6)./(p.Up*(1./(x(13))).*(1./(x(14))).*(1./(x(15)))); 
p7 = 4*(p.theta5^2)*(p.F7)./(240000*(1./(x(16))).*(1./(x(17)))); 
p8 = pi*(p.F8)./(p.Up*(1./(x(18))).*x(19).*x(20)); 
p9 = (p.eta3)*(p.theta6)*(p.F9)./(p.Up*(1./(x(21))).*(1./(x(22))).*(1./(x(23)))); 
p10 = 1.8;
p11 = 0.020;
 
% Compute nonlinear inequalities at x.
c = [t1 + t2 + t3 + t4 + t5 + t6 + t7 + t8 + t9 + t10 + t11 - p.T_max + 20;    
     p1 + p2 + p3 + p4 + p5 + p6 + p7 + p8 + p9 + p10 + p11 - p.P_max + 49.5];

ceq = [];   % Compute nonlinear equalities at x.
end
