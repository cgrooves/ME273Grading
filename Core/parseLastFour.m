%--------------------------------------------------------------
% FILE: 
% AUTHOR: Caleb Groves
% DATE: 1/17/18
% 
% PURPOSE: Parse the name of a student's file submission in order to
% extract the last four digits of their BYU ID.
%
%
% INPUT: String containing the filename to parse.
%
%
% OUTPUT: Last four digits of student's BYU ID, if contained after the
% first underscore in the filename. Otherwise, returns the string 'ERROR'.
%
%
% NOTES: 
%
%--------------------------------------------------------------
function last4 = parseLastFour(filename)

    % start going through each letter in the filename
    for i = 1:length(filename)
       
        % check to see if letter is underscore
        if filename(i) == '_'
            last4 = str2num(filename(i+1:i+4));
            return;
        end
    end
    
    % return ERROR
    last4 = 'ERROR';

end