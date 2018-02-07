function [score, fileFeedback] = graderTemplate(filename)

    try
        % save state in case student runs "clear" in their function
        f = filename(1:end-2); % get function name
        save('gradingvars.mat');

        % alter outputs and inputs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % EX: eval(['[output1, output2] = ',f,'(input1, input2);'])
        eval(['[score, fileFeedback] = ',f,'(file);']);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        load('gradingvars.mat');
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % grading algorithm - assign scores here and feedback here
        
        %
        %
        %
        
        % NORMALIZE THE SCORE (0 <= score <= 1)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    catch
        
        load('gradingvars.mat'); % re-load grading script data and variables
        score = 0; % give score of 0
        fileFeedback = ERROR.getReport; % store the stack trace in scores
        
    end
    
end