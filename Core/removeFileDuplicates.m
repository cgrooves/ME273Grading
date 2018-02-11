%--------------------------------------------------------------
% FILE: 
% AUTHOR: Caleb Groves
% DATE: 2/10/18
% 
% PURPOSE: Finds all files that have the same four digits that can be
% parsed out of their filename and deletes all but the latest one.
%
%
% INPUT: @param files - files struct containing all files to filter
%
%
% OUTPUT: None; but alters files on the hard drive
%
%
% NOTES: 
%
%--------------------------------------------------------------

function removeFileDuplicates(files)

% for each file
for i = 1:length(files)
    
    % find all matches
    last4 = parseLastFour(files(i).name);
    minNameMatch = strcat('*',num2str(last4),'*');
    filematches =  dir(fullfile(files(i).folder,minNameMatch));
    
    keepfile = files(i);
    
    for j = 1:length(filematches)
        if strcmp(keepfile.name,filematches(j).name)
            continue;
        elseif keepfile.date > filematches(j).date
            delete(fullfile(filematches(j).folder,filematches(j).name));
            disp(filematches(j).name);
        else
            delete(fullfile(keepfile.folder,keepfile.name));
            disp(keepfile.name);
            keepfile = filematches(j);
        end
    end

end

end