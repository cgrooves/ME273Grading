%--------------------------------------------------------------
% FILE: 
% AUTHOR: Caleb Groves
% DATE: 1/25/18
% 
% PURPOSE: Remove extraneous characters and information from student file
% submissions before autograding. 
%
%
% INPUT: String containing a unique part of the folder's name whose files
% you wish to get. Files are assumed to have some beginning description, an
% underscore, and then the last 4 digits of the student's BYU ID.
%
%
% OUTPUT: All matlab files with only the beginning description, an
% underscore, and the last 4 of their BYU ID.
% Ex: 'Animation_1552 - Tony Stark.m' --> 'Animation_1552.m'
%
%
% NOTES: 
%
%--------------------------------------------------------------

function files = prepareFiles(folderIdentifier)

% Get folder dir and add to path
newPath = dir(strcat('*',folderIdentifier,'*'));
addpath(newPath.name);

% get old files
files = dir(strcat(newPath.name,'/*.m'));

% remove spacing from name and save
for i = 1:length(files)
    newName = ''; % clear newName
    oldName = files(i).name; % old name
    % cut off all char's after last 4
    for i = 1:length(oldName)
        if oldName(i) == '_'
            newName(i:i+4) = oldName(i:i+4);
            newName = strcat(newName,'.m');
            break;
        else
            newName(i) = oldName(i);
        end
    end
    
    % before trying to move file, check to see if this
    % has already been done (can't move onto itself)
    if (size(oldName,2) ~= size(newName,2)) || any(oldName ~= newName)
        movefile(strcat(newPath.name,'/',oldName),strcat(newPath.name,'/',newName));
    end
    %end
    
end

files = dir(strcat(newPath.name,'/','*.m'));

end