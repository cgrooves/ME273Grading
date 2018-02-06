function [score, outputCells] = gradeAssignments(student,masterLab,files)

% for each assignment listed for this lab
for a = keys(masterLab.assignments)
    
    % go through each for file this assignment folder
    for i = 1:length(files)
        
        % parse last 4
        last4 = parseLastFour(files(i).name);
        
        % file last 4 matches current student's last four?
        try
            s = student(last4); % assumes yes
            gradeFile = true;
            
            % assignment already exists?
            try
                assignment = s.labs(masterLab.name).assignments(a); % assumes yes
                
                % Is this a new submission?
                if files(i).date > assignment.file.date
                    assignment = Assignment(a); % clear file
                    assignment.file = files(i); % update
                else
                    gradeFile = false; % don't grade
                end
                
            catch % no assignment found
                
                s.assignments(a) = Assignment(a); % add assignment
                s.assignments(a).file = files(i);
                assignment = s.assignments(a).file;
                
            end
            
            % check if grading should run
            if gradeFile
               % grade assignment
               gradingFunction = masterLab.assignments(a).file;
               eval(['[score, fileFeedback] = ',gradingFunction(1:end-2),'(files(i));']);
               
               % assign score and feedback to student assignment
               assignment.codeScore = score;
               assignment.feedback = fileFeedback;
               
            end
                
        catch % no student found
            % next file
        end
        
    end
end

end
                