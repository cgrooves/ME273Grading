function [score, outputCells] = gradeAssignments(student,masterLab,files)
% for each assignment listed for this lab
for a = keys(masterLab.assignments)
    % go through each for file this assignment folder
    for i = 1:length(files)
        
        % parse last 4
        last4 = parseLastFour(files(i).name);
        
        % matches current students?
        try
            assignment = student(last4)