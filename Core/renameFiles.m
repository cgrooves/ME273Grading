%--------------------------------------------------------------
% FILE: renameFiles.m
% AUTHOR: Caleb Groves
% DATE: 2/10/18
% 
% PURPOSE: Renames the files according to the assignment name passed in,
% and replaces them.
%
%
% INPUT: % @param assignmentName - char string of assignment name
% @param files - files struct containing all files to rename/replace
%
%
% OUTPUT: None; but alters files on the hard drive
%
%
% NOTES: 
%
%--------------------------------------------------------------
function renameFiles(files, assignmentName)

for i = 1:length(files)
    
    % construct new filename
    last4 = num2str(parseLastFour(files(i).name)); % get last 4
    newName = strcat(assignmentName,'_',last4,'.m');
    
    % check to see if file needs to be replaced
    if strcmp(files(i).name,newName)
        continue;
    else
        movefile(fullfile(files(i).folder,files(i).name),fullfile(files(i).folder,newName));
    end

end