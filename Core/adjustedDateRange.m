function [date1, date2] = adjustedDateRange(student,dueDate,resubmissionFlag)

    % get assignment due date
    section = student.section; % get student section number
    
    adjDueDate = dueDate; % initialize adjusted due date
    
    % find adjusted due date
    switch section
        case 1 % Tuesday lab
            adjDueDate = dueDate + 1;
        case 2 % Wed. lab
            adjDueDate = dueDate + 2;
        case 3 % Thurs. lab
            adjDueDate = dueDate + 3;
        case 4 % Fri. lab
            adjDueDate = dueDate + 4;
        case 5 % Mon. lab
            adjDueDate = dueDate + 0;
    end
    
    % assign output dates
    % use resubmission flag
    if resubmissionFlag
        date1 = adjDueDate;
        date2 = dueDate + 14;
    else
        date1 = datetime(0,0,0,0,0,0);
        date2 = adjDueDate;
    end
    
            
end