%--------------------------------------------------------------
% FILE: 
% AUTHOR: Caleb Groves
% DATE: 2/10/18
% 
% PURPOSE: Grade all assignment files and assign scores and feedback to a
% student.
%
%
% INPUT: assignmentFiles - structure containing all files for this
% particular assignment
% assignmentName - string with assignment name
% assignmentGrader - a function that returns a normalized assignment score
% and pertinent feedback and takes the name of a file.
% students - map container of Student objects
% labName - name of the lab being graded that assignments belong to
% resubmissionFlag - 1 if this is running in resubmission mode, where
% 20% is docked from each assignment grade, or normal mode
%
%
% OUTPUT: None, but updates the Student map passed into it
%
%
% NOTES: 
%
%--------------------------------------------------------------

function gradeAssignments(assignmentFiles,assignmentName,assignmentGrader,students,labName,resubmissionFlag)

for i = 1:length(assignmentFiles)

    % try finding a student match
    try
        last4 = parseLastFour(assignmentFiles(i).name);
        s = students(last4);
    catch
        % raise an error
        error('%d was not found in the student database; this should have been caught sooner',last4);
    end
    
    % get lab and assignment pointers
    try
        lab = s.labs(labName);
    catch
        error('%s was not found in %d''s labs list',labName,last4);
    end
    
    try
        assignment = lab.assignments(assignmentName);
    catch
        error('The %s assignment was not found in %d''s %s assignment list',...
            assignmentName,last4,labName);
    end
    
    % run grading script
    try
        eval(['[codeScore, codeFeedback] =',assignmentGrader(1:end-2),'(assignmentFiles(i).name);']);
    catch ERR
        assignment.codeScore = 0;
        assignment.totalFeedback = ERR.getReport;
    end
    
    % assign code score and feedback
    assignment.codeScore = ceil(codeScore);
    assignment.codeFeedback = codeFeedback;
    
    % try grading the header and comments
    try
        % get header and comment scores
        [headerScore, headerFeedback, commentScore, commentFeedback, err] = ...
            HeaderCommentGrader_V1(assignmentFiles(i).name);
        
        assignment.headerScore = ceil(headerScore);
        assignment.headerFeedback = headerFeedback;
        assignment.commentScore = ceil(commentScore);
        assignment.commentFeedback = commentFeedback;
    catch
        line1 = 'You have formatted your headers or comments rather strangely, which has caused an autograder failure.';
        line2 = ' Be sure to use the given header template, and make sure header is at the top (head).';
        assignment.headerFeedback = strcat(assignment.headerFeedback,line1,line2);
    end
    
    % calculate assignment grade and update student database
    assignment.submissionDate = assignmentFiles(i).date;
    assignment.name = assignmentName;
      
    assignment.calculateScore(resubmissionFlag);

end
    
end