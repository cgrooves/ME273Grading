%% create templates
% create master lab
masterLab = Lab('Lab2');
masterLab.submissionDate = datetime(2018,1,17,16,0,0);

masterLab.assignments('Animation') = Assignment('Animation');
masterLab.assignments('Pythag') = Assignment('Pythag');

% grader files
graderFunctions = containers.Map;
graderFunction('Animation') = 'animationGrader.m';
graderFunction('Pythag') = 'pythagGrader.m';

%%
% prepare all folders/files
% for each assignment in the master lab
assignmentFiles = containers.Map;

for a = keys(masterLab.assignments)
    assignmentFiles(a) = prepareFiles(a); % get all assignment files
end

% get/create student database
try
    load('students.mat','students');
catch
    createStudentDatabase('roster.csv','students.mat');
    load('students.mat','students');
end

    
%%
% load lab submissions
try
    responses = readtable('labresponses.csv','Delimiter','\t');
    labResponses = table2cell(responses);
catch
    error('Lab responses must be in a file in the directory called ''labresponses.csv''');
end

% Go through each lab submission
for r = 1:size(labResponses,1)
   
    clear s lab;
    
    % find a match
    try
%         last4 = labResponses{r,2}; % get last 4
        s = students(labResponses{r,2}); % get Student from database that matches
        
        % try to match the lab
        try
            lab = s.labs(masterLab.name); % lab exists?
            
            % check timestamp
            timestamp = labResponses{r,1};
            
            if timestamp > lab.submissionDate % if submission is newer
                lab.graded = false; % set to re-grade
            else
                break; % move on
            end
            
        catch % lab doesn't exist
            s.labs(masterLab.name) = Lab(masterLab.name); % add to student
            lab = s.labs(masterLab.name);
            lab.submissionDate = labResponses{r,1}; % add timestamp
        end
        
        % check if lab is already graded
        if lab.graded
            break;
        else
            % grade lab
            lab.selfEvaluationScore = labResponses{r,5};
            lab.selfEvaluationFeedback = labResponses{r,6};
            lab.peerObservationScore = labResponses{r,7};
            lab.peerObservationFeedback = labResponses{r,8};
            
            % get late weight
            lateWeight = getLateWeight(masterLab.submissionDate,lab.submissionDate,s.section);
            
            % allocate feedback
            numAssignments = size(masterLab.assignments,1);
            output = cell(1,11 + numAssignments*8);
            
            % starting output index
            n = 12;
            assignmentScores = 0;
            
            % grade each assignment in the master lab
            for a = keys(masterLab.assignments)
                % get score and feedback
                [assignmentScore, assignmentFeedback] = gradeAssignment(a,s,masterLab.name,graderFunctions(a),assignmentFiles(a));
                assignmentScores = assignmentScores + assignmentScore;
                
                % store assignment feedback
                output(n:n+7) = assignmentFeedback;
                n = n + 8;
            end
            
            % calculate overall lab score
            lab.score = lateWeight*(0.8*assignmentScores + 0.1*(lab.selfEvaluationScore + lab.peerObservationScore));
            
            % store all feedback
            output{1} = s.lastName;
            output{2} = s.firstName;
            output{3} = s.last4;
            output{4} = s.email;
            output{5} = lab.name;
            output{6} = lab.score;
            output{7} = lateWeight;
            output{8} = lab.selfEvaluationScore;
            output{9} = lab.selfEvaluationFeedback;
            output{10} = lab.peerObservationScore;
            output{11} = lab.peerObservationFeedback;
            
            
        end
        
    catch % if no student match is found
       disp(strcat(num2str(labResponses{r,2}),' is not a recognized BYUID.'));
    end
    
end