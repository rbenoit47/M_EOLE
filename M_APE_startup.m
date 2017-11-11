%SCRIPT_NAME - M_APE_startup   SYS847
%M_APE_startup performs required tasks to initiate the use of the M_APE
%kit in MATLAB.
%This script SHOULD typically be called by a startup* script located in
%your MATLAB home directory.
%
% Syntax:  M_APE_startup
%
% Inputs:
%    none
%
% Outputs:
%    none
%
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% For more information, see <a href="matlab: 
% web('http://www.anemoscope.ca/Intro_en.html')">the AnemoScope site</a>,
% and also <a href="matlab:web('http://sourceforge.net/projects/westose')">the WEST site</a>.
%  
% 
% Author: Robert Benoit, Ph.D.
% email address: robert.benoit.47@gmail.com 
%
% See also: 

%------------- BEGIN CODE --------------
%
Me=mfilename();
w=which(Me);
[pathstr,~,~]=fileparts(w);
M_APE_PATH=pathstr; %pwd;
setenv('M_APE_PATH',M_APE_PATH)
%
addpath(genpath(M_APE_PATH))
%
fprintf('\n----------------------\n  Configuration de MATLAB pour M_APE faite\n----------------------\n')
%
M_path=path;
splits=regexp(M_path,';','split');
pc=char(splits);
[nstr,nlen]=size(pc);
fprintf('\n\n Portion M_APE du search path de MATLAB: \n----------------------------\n')
for i=1:nstr
    pci=pc(i,:);
    j=strfind(pci,M_APE_PATH);
    if ~isempty(j)
        fprintf('%s\n',pci)
    end
end
fprintf('\n--------------------------\n')
% change CLIMATE_PREFIX to CAN1, proper for APE project using Canadian Wind Atlas data
% nov 2017
setenv('WEST_CLIMATE_PREFIX','CAN1')
fprintf('\n\nWEST_CLIMATE_PREFIX changed to CAN1 at startup for APE project\n\n')