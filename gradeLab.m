clc; clear;

%% create templates
% create master lab
masterLab = Lab('Lab2');
masterLab.submissionDate = datetime(2018,1,17,16,0,0);

%masterLab.assignments('Animation') = Assignment('Animation');
masterLab.assignments('Pythag') = Assignment('Pythag');

numAssignments = size(masterLab.assignments,1);

% grader files
graderFunctions = containers.Map;
%graderFunctions('Animation') = 'animationGrader.m';
graderFunctions('Pythag') = 'pythagGrader.m';

%%
% prepare all folders/files
% for each assignment in the master lab
assignmentFiles = containers.Map;

for a = keys(masterLab.assignments)
    assignmentFiles(a{1}) = prepareFiles(a{1}); % get all assignment files
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

% Initialize writeCell - the cell with all current feedback to be written
% to file
writeCell = {};
cRow = 1;

% Go through each lab submission
for r = 1:size(labResponses,1)
   
    clear s lab;
    
    % find a match
    try
        s = students(labResponses{r,3}); % get Student from database that matches
        
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
            lab.selfEvaluationScore = labResponses{r,5}/5;
            lab.selfEvaluationFeedback = labResponses{r,6};
            lab.peerObservationScore = labResponses{r,7}/5;
            lab.peerObservationFeedback = labResponses{r,8};
            
            % get late weight
            lateWeight = getLateWeight(masterLab.submissionDate,lab.submissionDate,s.section);
            
            % allocate feedback
            output = cell(1,12 + numAssignments*8);
            
            % starting output index
            n = 13;
            assignmentScores = 0;
            
            % grade each assignment in the master lab
            for a = keys(masterLab.assignments)
                % get score and feedback
                [assignmentScore, assignmentFeedback] = gradeAssignment(a{1},s,masterLab.name,graderFunctions(a{1}),assignmentFiles(a{1}));
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
            output{3} = s.BYUID;
            output{4} = s.last4;
            output{5} = s.email;
            output{6} = lab.name;
            output{7} = lab.score;
            output{8} = lateWeight;
            output{9} = lab.selfEvaluationScore;
            output{10} = lab.selfEvaluationFeedback;
            output{11} = lab.peerObservationScore;
            output{12} = lab.peerObservationFeedback;
            
            % add output to writeCell
            writeCell(cRow,:) = output;
            cRow = cRow + 1;
            
            lab.graded = true;
                        
        end
        
    catch % if no student match is found
       disp(strcat(num2str(labResponses{r,3}),' is not a recognized BYUID.'));
    end
    
end

% write the cell to table, table to file
% write the table headers
clear headers;
%headers = cell(1,11 + numAssignments*8);
headers{1} = 'LastName';
headers{2} = 'FirstName';
headers{3} = 'BYUID';
headers{4} = 'Last4';
headers{5} = 'Email';
headers{6} = 'LabName';
headers{7} = 'TotalLabScore';
headers{8} = 'LateWeight';
headers{9} = 'SelfEvaluationScore';
headers{10} = 'SelfEvaluationFeedback';
headers{11} = 'PeerObservationScore';
headers{12} = 'PeerObservationFeedback';

% Get all assignment feedback headers
i = 13;
for a = keys(masterLab.assignments)
    headers{i} = strcat(a{1},'Assignment');
    headers{i+1} = strcat(a{1},'Score');
    headers{i+2} = strcat(a{1},'CodeScore');
    headers{i+3} = strcat(a{1},'CodeFeedback');
    headers{i+4} = strcat(a{1},'HeaderScore');
    headers{i+5} = strcat(a{1},'HeadersFeedback');
    headers{i+6} = strcat(a{1},'CommentScore');
    headers{i+7} = strcat(a{1},'CommentFeedback');
    
    i = i + 8;
end

% turn cell into table
tableOut = cell2table(writeCell,'VariableNames',headers);

% write table out to .csv
outFileName = strcat(masterLab.name,'graded',datestr(now),'.csv');% .csv name
writetable(tableOut,outFileName);