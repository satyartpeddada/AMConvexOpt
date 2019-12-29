%% IISE 2020 Conference Paper 
% %--------------------------------------------------------------------------
% CombinedPareto.m
% %--------------------------------------------------------------------------
% This function plots both the original and the disrupted cell Pareto
% fronts on a single plot
%--------------------------------------------------------------------------
% Contributors: Satya RT Peddada (github: satyartpeddada) & Albert E. Patterson 
% Department of ISE, University of Illinois at Urbana-Champaign
%--------------------------------------------------------------------------

%% FOR THIS CODE TO WORK PLEASE LOAD THE 'original.mat' AND 'disrupted.mat' FILES GENERATED
%% BY RUNNING THE 'CaseStudy1_Pareto.m' AND 'CaseStudy1_DisruptedCellPareto.m' MATLAB FILES  


%%  ORIGINAL CELL PARETO PLOT
figure;
plot(o1,o2,'b.','MarkerSize',14);
xlabel('Time (min)');
ylabel('Power[kW]');
title('Pareto - Time vs. Power for Machine Cell w/o Disruption')
 

%% DISRUPTED CELL PARETO PLOT
figure;
plot(o1_disrupt,o2_disrupt,'b.','MarkerSize',14);
xlabel('Time (min)');
ylabel('Power[kW]');
title('Pareto - Time vs. Power for Machine Cell with Disruption')


%% COMBINED PARETO PLOT
figure;
loglog(o1,o2,'r.','MarkerSize',14);
hold on
loglog(o1_disrupt,o2_disrupt,'b.','MarkerSize',14);
xlabel('Time (min)');
ylabel('Power [kW]');
title('Comparison plot between machine cell w/o and with disruption')
legend('Without disruption', 'With AM disruption')


%% AXIS Limits : CHANGE ACCORDINGLY
hf = gca;
% hf.YLim = [10 50];
% hf.YTick = [10 20 50 100 200];
hf.XLim = [90 140];
