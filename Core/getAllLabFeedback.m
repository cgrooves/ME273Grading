

function getAllLabFeedback(students,masterLab)

% get number of assignments
numAssignments = size(keys(masterLab.assignments),2);

% get lab feedback for all students
allFeedback = {};
i = 1; % index

for last4 = keys(students)
    
    % get feedback for each student
    row = getLabFeedback(students(last4{1}),masterLab);
    
    allFeedback(i,:) = row;
    
    i = i + 1; % increment index
end

% write cell to table

% write the table headers
clear headers;

headers = cell(1,11 + numAssignments*9);
headers{1} = 'LastName';
headers{2} = 'FirstName';
headers{3} = 'BYUID';
headers{4} = 'Last4';
headers{5} = 'Email';
headers{6} = 'LabName';
headers{7} = 'TotalLabScore';
headers{8} = 'SelfEvaluationScore';
headers{9} = 'SelfEvaluationFeedback';
headers{10} = 'PeerObservationScore';
headers{11} = 'PeerObservationFeedback';

% Get all assignment feedback headers
i = 12;

for a = keys(masterLab.assignments)
    headers{i} = strcat(a{1},'Assignment');
    headers{i+1} = strcat(a{1},'Score');
    headers{i+2} = strcat(a{1},'Feedback');
    headers{i+3} = strcat(a{1},'CodeScore');
    headers{i+4} = strcat(a{1},'CodeFeedback');
    headers{i+5} = strcat(a{1},'HeaderScore');
    headers{i+6} = strcat(a{1},'HeadersFeedback');
    headers{i+7} = strcat(a{1},'CommentScore');
    headers{i+8} = strcat(a{1},'CommentFeedback');
    
    i = i + 9;
end

% turn cell into table
tableOut = cell2table(allFeedback,'VariableNames',headers);

% write out tables

% write feedback table out to .csv
FeedbackFolder = 'GradingFeedback';

if ~exist(FeedbackFolder,'dir')
    mkdir(FeedbackFolder);
end

outFileName = fullfile(FeedbackFolder,strcat(masterLab.name,'Feedback',datestr(now),'.csv')); % .csv name
writetable(tableOut,outFileName,'Delimiter','\t');

% write out file to upload to learning suite
LSFolder = 'LearningSuiteUpload';

if ~exist(LSFolder,'dir')
    mkdir(LSFolder);
end

uploadFileName = fullfile(LSFolder,strcat(masterLab.name,'LearningSuiteUpload',datestr(now),'.csv'));
jj = allFeedback(:,1:7);

for i = 1:size(jj,1)
    jj{i,7} = 50*jj{i,7};
end

scoresTable = cell2table(jj,'VariableNames',{'LastName','FirstName','BYUID'...
    ,'Last4','Email','LabName','TotalLabScore'});
writetable(scoresTable,uploadFileName);

end