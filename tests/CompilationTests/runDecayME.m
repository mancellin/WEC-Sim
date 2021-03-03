%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright 2014 the National Renewable Energy Laboratory and Sandia Corporation
% 
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
% 
%     http://www.apache.org/licenses/LICENSE-2.0
% 
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Run the WEC-Sim Applications Repo Decay case
% This script will run the sphere decay case in the 
% WEC-Sim Applications repo but with a short simulation time.
locdir = pwd;
casedir = '..\..\..\WEC-Sim_Applications\Free_Decay\1m-ME\';

inputfile = [casedir '\wecSimInputFile.m'];
plotfile = [casedir '\userDefinedFunctions.m'];

%% Change application input and plot files
% read original input file
fileID = fopen(inputfile,'r');
old_input = textscan(fileID,'%s','Delimiter','\n\r');  % Read/copy raw output and new lines
old_input = old_input{:};
fclose(fileID);

% append short simulation time to input file
fileID = fopen(inputfile,'a');
fprintf(fileID,'%s\n',"simu.explorer = 'off';");
fprintf(fileID,'%s\n',"simu.startTime = 0;");
fprintf(fileID,'%s\n',"simu.rampTime = 2;");
fprintf(fileID,'%s\n',"simu.endTime = 4;");
fprintf(fileID,'%s\n',"simu.dt = 0.1;");
fclose(fileID);

%% Run Simulation
cd(casedir)
wecSim;                     % Run Simulation
fprintf('wec sim done \n');
cd(locdir)

%% Restore old files
% Restore original input file
fileID = fopen(inputfile,'w');
for i=1:length(old_input)
    fprintf(fileID,'%s\r\n',old_input{i});
end
fclose(fileID);

%% Post-Process Data
% No need to post-process data, save output, or plot comparisons
% necessary to restore old application run?
