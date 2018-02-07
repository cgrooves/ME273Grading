% Output: the score and all feedback for the part of the lab for this
% student
% Input: 

function [score, outputCells] = gradeAssignment(assignmentName,s,labName,assignmentGrader,files)

% initialize score and outputCells
score = 0;
outputCells = cell(1,8);

outputCells{1,1} = assignmentName;
for i = 2:8
    outputCells{1,i} = 'No file found';
end

% go through each file in this assignment folder
for i = 1:length(files)

    % parse last 4
    last4 = parseLastFour(files(i).name);

    % file last 4 matches current student's last four?
    if s.last4 == last4
            
        gradeFile = true;

        % assignment already exists?
        try
            assignment = s.labs(labName).assignments(assignmentName); % assumes yes

            % Is this a new submission?
            if files(i).date > assignment.file.date
                % If the file is newer than the one on record
                assignment = Assignment(assignmentName); % clear the one on record
                assignment.file = files(i); % update it
            else
                gradeFile = false; % don't grade
            end

        catch % no assignment found
            
            assignments = s.labs(labName).assignments;
            assignments(assignmentName) = Assignment(assignmentName); % add assignment
            assignment = s.labs(labName).assignments(assignmentName);
            assignment.file = files(i);

        end

        % check if grading should run
        if gradeFile
           % grade assignment
           eval(['[codeScore, fileFeedback] = ',assignmentGrader(1:end-2),'(files(i).name);']);

           % assign score and feedback to student assignment
           assignment.codeScore = codeScore;
           assignment.feedback = fileFeedback;

           % Run comments and header functions
           [headerScore, headerFeedback, commentScore, commentFeedback, err] = HeaderCommentGrader_V1(files(i).name);

           % Compute total score
           score = .125*(headerScore + commentScore) + .75*(codeScore);
           
           % Assign output cells
           outputCells{1,2} = score;
           outputCells{1,3} = codeScore;
           outputCells{1,4} = fileFeedback;
           outputCells{1,5} = headerScore;
           outputCells{1,6} = headerFeedback;
           outputCells{1,7} = commentScore;
           outputCells{1,8} = commentFeedback;
        else
            
            error('I don''t think I should ever see this error message');

        end

    else % file's last 4 doesn't match student's last 4
        % next file
    end

end

end
