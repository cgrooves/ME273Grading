function [score, fileFeedback] = graderTemplate(filename)

    try
        f = filename(1:end-2); % get function name

        % alter outputs and inputs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % EX: eval(['[output1, output2] = ',f,'(input1, input2);'])
        eval(['[score, fileFeedback] = ',f,'(file);']);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % grading algorithm - assign scores here and feedback here
        
        %
        %
        %
        
        % NORMALIZE THE SCORE (0 <= score <= 1)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    catch
        
        score = 0; % give score of 0
        fileFeedback = regexprep(ERR.message,'\n',' ');
        
    end
    
end
