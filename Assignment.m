classdef Assignment < handle
    
    properties
        name
        file
        
        codeScore % 0-1
        headerScore % 0-1
        headerFeedback
        commentScore % 0-1
        commentFeedback
        feedback % string
    end
    
    methods
        % Constructor -------------------------------
        function self = Assignment(name)
            
            self.name = name;
            self.feedback = '';
            self.headerFeedback = '';
            self.commentFeedback = '';
            self.codeScore = 0;
            self.headerScore = 0;
            self.commentScore = 0;
            
        end
        %--------------------------------------------

        
    end
    
end