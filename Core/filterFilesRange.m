%--------------------------------------------------------------
% FILE: 
% AUTHOR: Caleb Groves
% DATE: 2/10/18
% 
% PURPOSE: Delete any files passed in that: do not match a student in the
% database, are not within the submission date range, or that are older
% than the student's current submission.
%
%
% INPUT: @param files - files struct containing all files to filter
% @param labName - name of lab that's being graded
% @param dueDate - datetime structure with the Monday due date for the lab
% in question
% @param resubmissionFlag - boolean value that's 1 if this is a
% resubmission grading, or 0 if this is a normal grading routine
%
%
% OUTPUT: None; but alters files on the hard drive
%
%
% NOTES: 
%
%--------------------------------------------------------------
function filterFilesRange(files,students,labName,assignmentName,dueDate,resubmissionFlag)

% go through files
for i = 1:length(files)
    filepath = fullfile(files(i).folder,files(i).name);
    
    % check to see if file belongs to student
    try % try finding a match
        last4 = parseLastFour(files(i).name);
        studentMatch = students(last4);
        
    catch % if no match is found, remove it
        delete(filepath);
        continue; % next file
    end
    
    % Check to see if file is between dates
    fileDate = files(i).date; % get file submission date
    
    % get adjusted date range
    [date1, date2] = adjustedDateRange(studentMatch, dueDate, resubmissionFlag);
    
    % if it's outside the date range
    if fileDate > date2 || fileDate < date1
        delete(filepath);
        continue; % next file
    end
    
    % Check to see if file is newer than file already existing
    lab = studentMatch.labs(labName);
    assignment = lab.assignments(assignmentName);
    
    if assignment.submissionDate >= fileDate
        delete(filepath);
        continue;
    end
    
end % end of files search

end