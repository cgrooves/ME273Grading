% Load database of students: Takes in a file with a roster of students
% (.csv file) and uses the Student class to create a database, saved as a
% .mat file, of the students and their information, to be used in grading
% assignments and keeping track of submissions.

function createStudentDatabase(rosterFile,outputFile)

    % import roster file (.csv)
    rosterTable = readtable(rosterFile);
    rosterCell = table2cell(rosterTable); % convert to cell array
    
    numStudents = size(rosterCell,1);
    
    students = containers.Map('KeyType','uint32','ValueType','any');
    
    % for each row
    for i = 1:numStudents
        % load each student's column into a Student object
        last4 = rosterCell{i,6};
        
        students(last4) = Student;
        s = students(last4);
        s.lastName = rosterCell{i,1};
        s.firstName = rosterCell{i,2};
        s.BYUID = rosterCell{i,5};
        s.last4 = rosterCell{i,6};
        s.netID = rosterCell{i,3};
        s.email = rosterCell{i,4};
        s.section = rosterCell{i,9};
               
        
    end % next row
    
    % save the Student object array
    save(outputFile,'students');

end