%--------------------------------------------------------------
% FILE: 
% AUTHOR: Caleb Groves
% DATE: 2/10/18
% 
% PURPOSE: 
%
%
% INPUT: 
%
%
% OUTPUT: 
%
%
% NOTES: 
%
%--------------------------------------------------------------

function files = prepareFiles(assignmentName,labName,students,dueDate,resubmissionFlag)

% Get folder dir and add to path
newPath = dir(strcat('*',assignmentName,'*'));
addpath(newPath.name);

% get list files in assignment directory
files = dir(fullfile(newPath.name,'*.m'));

% remove all files that don't match students, outside appropriate date
% range, or are older than the student's current submission for this
% assignment
filterFilesRange(files,students,labName,assignmentName,dueDate,resubmissionFlag);

% update files structure
files = dir(fullfile(newPath.name,'*.m'));

% remove any duplicate files
removeFileDuplicates(files);

% update files structure
files = dir(fullfile(newPath.name,'*.m'));

% format file names
renameFiles(files,assignmentName);

% final update of files struct
files = dir(fullfile(newPath.name,'*.m'));

end
