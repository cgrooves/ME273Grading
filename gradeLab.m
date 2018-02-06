%% create templates
masterLab = Lab('Lab2');
masterLab.submissionDate = datetime(2018,2,5,16,0,0);
masterLab.assignments('SixDerivs') = Assignment('SixDerivs');
masterLab.assignments('DerivPlot') = Assignment('DerivPlot');
masterLab.assignments('FBC') = Assignment('FBC');

%%
% prepare all folders/files
% for each assignment in the master lab
i = 1;
for a = keys(masterLab.assignments)
    assignmentFiles{i} = prepareFiles(a); % get all assignment files
end

% get/create student database
try
    load('students.mat','students');
catch
    createStudentDatabase('roster.csv','students.mat');
    load('students.mat','students');
end

    
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
            lab.peerObservationScore = labResponses{r,4};
            
            % get late weight
            lateWeight = getLateWeight(masterLab.submissionDate,lab.submissionDate,s.section);
            
            % grade each assignment in the master lab
            
            
            
        end
        
    catch % if no student match is found
       disp(strcat(num2str(labResponses{r,2}),' is not a recognized BYUID.'));
    end
    
end