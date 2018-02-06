classdef Assignment < handle
    
    properties
        name
        file
        
        codeScore % 0-1
        headerScore % 0-1
        commentScore % 0-1
        feedback % string
    end
    
    methods
        % Constructor -------------------------------
        function self = Assignment(name)
            
            self.name = name;
            self.feedback = '';
            
        end
        %--------------------------------------------

        
    end
    
end