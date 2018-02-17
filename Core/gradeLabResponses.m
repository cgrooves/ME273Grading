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
    
    % We only ever want to grade the first submission, but just in case
    % we'll only take the highest peer observation/self evaluation scores
    % if this submission is newer
    
    if timestamp > lab.submissionDate % update submission time
        lab.submissionDate = timestamp;
    end
        
    % grade lab
    [newSelfEvaluationScore, newSelfEvaluationFeedback] = ...
        responseScoreGrader(labResponses{r,4});

    [newPeerObservationScore, newPeerObservationFeedback] = ...
        responseScoreGrader(labResponses{r,6});

    % only record highest response
    if newSelfEvaluationScore > lab.selfEvaluationScore
        lab.selfEvaluationScore = newSelfEvaluationScore;
        lab.selfEvaluationFeedback = newSelfEvaluationFeedback;
    end

    if newPeerObservationScore > lab.peerObservationScore
        lab.peerObservationScore = newPeerObservationScore;
        lab.peerObservationFeedback = newPeerObservationFeedback;
    end


end

end