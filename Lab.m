classdef Lab < handle
    
    properties
        name
        
        assignments
        submissionDate
        score
        
        selfEvaluationScore
        selfEvaluationFeedback
        peerObservationScore
        peerObservationFeedback
        
        graded
    end
    
    methods
        % Constructor -----------------------------
        function self = Lab(name)
            
            self.name = name;
            self.assignments = containers.Map;
            self.graded = false;
            
        end
        %------------------------------------------
    end
    
end