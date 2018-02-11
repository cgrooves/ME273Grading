function gradeAllLabs(masterLab,students)

    % for each student
    for last4 = keys(students)
        s = students(last4{1});
        
        % make sure that student has this lab
        try
            lab = s.labs(masterLab.name);
        catch
            % if not, add it
            s.labs(masterLab.name) = Lab(masterLab.name);
            lab = s.labs(masterLab.name);
            
            % add all assignments
            for a = keys(masterLab.assignments)
                lab.assignments(a{1}) = Assignment(a{1});
            end
        end
        
        % grade the lab
        lab.calculateScore();
    end

end