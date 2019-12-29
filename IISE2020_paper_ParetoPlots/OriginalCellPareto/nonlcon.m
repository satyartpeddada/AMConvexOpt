%% IISE 2020 Conference Paper 
% %--------------------------------------------------------------------------
% nonlcon.m
%%--------------------------------------------------------------------------
% ORIGINAL CELL - Non-linear constraints 
%--------------------------------------------------------------------------
% Contributors: Satya RT Peddada (github: satyartpeddada) & Albert E. Patterson 
% Department of ISE, University of Illinois at Urbana-Champaign
%--------------------------------------------------------------------------
%%

function [c,ceq] = nonlcon(x,p,w)

%% Time functions 
% Tcell is sum of t1 through t6

t1 = p.V1./(p.eta1.*p.theta1.*x(1).*x(2).*x(3));
t2 = (1/2).*p.V2./(p.eta2.*p.theta2.*x(4).*x(5).*x(6));
t3 = (p.H1.*p.Ld1 + p.H2.*p.Ld2)/(x(7).*x(8)) + p.tm1.*(p.H1+p.H2-1);
t4 = ((2/3)*p.H1.*p.Ltap + (1/2).*p.D)/((p.TP).*x(10)) + p.tm2.*(p.H1-1);
t5 = p.V5./(pi.*x(11).*x(12).*2.^2);

% Add 8 minutes of transfer time for each step
t6 = 8*5;

%% Power functions
% Pcell is sum of p1 through p5

p1 = p.eta1*p.theta1.*p.Fc1/(p.Up*(1/(x(1))).*(1/(x(2))).*(1/(x(3))));
p2 = 2*p.eta2*p.theta2.*p.Fc2/(p.Up*(1./(x(4))).*(1./(x(5))).*(1./(x(6))));
p3 = (p.H1 + p.H2)*((p.theta3)^2)*(p.Fc3)/(p.Up*(1./(x(7))).*(1./(x(8))));
p4 = (p.H1)*((p.theta4)^2)*(p.Fc4)/(p.Up*(1./(x(9))).*(1./(x(10)))); % question about xp4
p5 = pi*p.Fc5/(p.Up*((1./(x(11))).*(1./(x(12))))); % Need to change design variables according to previous xp4 change

% Appending the T_max and P_max constraints
c = [t1 + t2 + t3 + t4 + t5  + t6 - p.T_max ;     % Compute nonlinear inequalities at x.
     p1 + p2 + p3 + p4 + p5 - p.P_max ];
ceq = [];   % Compute nonlinear equalities at x.
end
