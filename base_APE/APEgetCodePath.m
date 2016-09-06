function [ CodePath ] = APEgetCodePath()
%FUNCTION_NAME - APEgetCodePath   M_WEST
%   APEgetCodePath retourne le Path vers le présent module
%
% Syntax:  [ CodePath ] = APEgetCodePath()
%
% Inputs:
%    aucun
%
% Outputs:
%    CodePath - Path vers le présent module
%
% Example: 
%    APEgetCodePath()
%    ans =
%    M:\EOLE\projets\1_APE\M_WEST\scripts_generaux\m
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: M_WEST_startup

% Author: Robert Benoit, Ph.D.
% email address: robert.benoit.47@gmail.com 

%------------- BEGIN CODE --------------
Me=mfilename();
w=which(Me);
[pathstr,name,ext]=fileparts(w);
CodePath=pathstr;
end

