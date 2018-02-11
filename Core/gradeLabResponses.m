function errorID = gradeLabResponses(students,masterLab,labResponses)

% initialize errorID array
errorID = {};
e_count = 0;

% split up masterLab stuff
labName = masterLab.name;

% go through each row in the labresponses cell
for r = 1:size(labResponses,1)
    
    clear s lab;
    
    % only grade responses that have a student match
    try
        last4 = labResponses{r,2}; % get last 4
        s = students(last4); % find in student directory
    catch % no student match found
        e_count = e_count + 1;
        errorID{e_count} = last4;
        continue;
    end
    
    % check to see if current lab exists
    try
        lab = s.labs(labName);
    catch % add in lab if not
        s.labs(labName) = Lab(labName);
        lab = s.labs(labName);
        
        % add new lab assignments from masterLab
        for a = keys(masterLab.assignments)
            lab.assignments(a{1}) = Assignment(a{1});
        end
    end
    
    timestamp = labResponses{r,1}; % get responses timestamp
    
    % if this submission is newer
    if timestamp > lab.submissionDate
        % re-grade lab
        lab.submissionDate = timestamp;
        
        % grade lab
        [lab.selfEvaluationScore, lab.selfEvaluationFeedback] = ...
            responseScoreGrader(labResponses{r,4});

        [lab.peerObservationScore, lab.peerObservationFeedback] = ...
            responseScoreGrader(labResponses{r,6});

    else
        continue;
    end
end

end