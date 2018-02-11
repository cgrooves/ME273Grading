clc; clear;

addpath Core;

% set grading routine type: resubmission or not?
resubmitFlag = 0;

%% CREATE TEMPLATES ----------------------
% create master lab
masterLab = Lab('Lab3');

% set due date for lab
masterLab.submissionDate = datetime(2018,3,25,16,0,0); 

masterLab.assignments('SixDerivs') = Assignment('SixDerivs');
%masterLab.assignments('DerivPlot') = Assignment('DerivPlot');
masterLab.assignments('FBC') = Assignment('FBC');

numAssignments = size(masterLab.assignments,1);

% grader files
graderFunctions = containers.Map;
graderFunctions('SixDerivs') = 'sixDerivsGrader.m';
%graderFunctions('DerivPlot') = 'derivPlotGrader.m';
graderFunctions('FBC') = 'fbcGrader.m';

%% LOAD FILES -- ADVANCED SETUP HERE ----------------

% get/create student database
try
    load('students.mat','students');
catch
    createStudentDatabase('roster.csv','students.mat');
    load('students.mat','students');
end

% load lab submissions - must be tab-delimited file saved as .csv (I know
% it's weird, but commas in the student responses mess up actual .csv
% files, but matlab can't read a .tsv file)
try
    responses = readtable('labresponses.csv','Delimiter','\t');
    labResponses = table2cell(responses);
catch
    error('Lab responses must be in a file in the directory called ''labresponses.csv''');
end

%% Grading routines

% grade lab response submissions
[studentIDErrors] = gradeLabResponses(students,masterLab,labResponses);

%%
% grade all file submission

% get all pertinent file submissions
assignmentFiles = containers.Map;

for a = keys(masterLab.assignments) % for each assignment in the lab
    assignmentFiles(a{1}) = prepareFiles(a{1},masterLab.name,students,masterLab.submissionDate,resubmitFlag);
    
    % At this point the only files left in any folders should be files that are
    % new/haven't been graded, and correspond to either the resubmission mode
    % of running this program or the regular mode, using the masterLab's
    % submission date as the lab due date. These files should also have a valid
    % match to a student.
    
    % grade all files for this assignment and update student database
    gradeAssignments(assignmentFiles(a{1}),a{1},graderFunctions(a{1}),...
        students,masterLab.name,resubmitFlag);
    
end

% grade all labs
gradeAllLabs(masterLab,students);

% all assignments graded, save students variable
save('students.mat','students');

% compile and write out feedback and scores
getAllLabFeedback(students,masterLab);
