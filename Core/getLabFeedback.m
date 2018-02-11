%--------------------------------------------------------------
% FILE: 
% AUTHOR: Caleb Groves
% DATE: 2/10/18
% 
% PURPOSE: Grade all assignment files and assign scores and feedback to a
% student.
%
%
% INPUT: student - Student object to get feedback from
% masterLab - Lab object describing the lab to be graded
%
%
% OUTPUT: A cell array row with all of the scores and feedback for the lab
% specified by the masterLab.
%
%
% NOTES: 
%
%--------------------------------------------------------------

function out = getLabFeedback(student,masterLab)

    % get number of assignments
    numAssignments = size(masterLab.assignments,1);
    
    % allocate output cell size
    out = cell(1,11 + numAssignments*9);
    
    % get pointers to student info
    try
        lab = student.labs(masterLab.name);
    catch
        error('Student %d does not have %s.',student.last4,masterLab.name);
    end
    
    % fill in the generic lab cells
    out{1} = student.lastName;
    out{2} = student.firstName;
    out{3} = student.BYUID;
    out{4} = student.last4;
    out{5} = student.email;
    out{6} = lab.name;
    out{7} = lab.score;
    out{8} = lab.selfEvaluationScore;
    out{9} = lab.selfEvaluationFeedback;
    out{10} = lab.peerObservationScore;
    out{11} = lab.peerObservationFeedback;
    
    % go through the assignments and output the cells
    i = 12; % index
    for a = keys(lab.assignments)
        
        % get pointer to current assignment
        ass = lab.assignments(a{1}); % intentional
        
        out{i} = ass.name;
        out{i+1} = ass.totalScore;
        out{i+2} = ass.totalFeedback;
        out{i+3} = ass.codeScore;
        out{i+4} = ass.codeFeedback;
        out{i+5} = ass.headerScore;
        out{i+6} = ass.headerFeedback;
        out{i+7} = ass.commentScore;
        out{i+8} = ass.commentFeedback;
        
        % increment index
        i = i + 9;
    end

end