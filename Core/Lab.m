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
            self.score = 0;
            self.submissionDate = datetime(0,0,0,0,0,0);
            
            self.selfEvaluationScore = 0;
            self.selfEvaluationFeedback = 'No self evaluation found';
            self.peerObservationScore = 0;
            self.peerObservationFeedback = 'No peer observation found';
            
        end
        %------------------------------------------
        function score = calculateScore(self)
            
            % 50 pts: 5 each for SE and PO, 40 for code
            % get total assignment scores
            assignmentScore = 0;
            
            n = size(keys(self.assignments),2);
            
            for a = keys(self.assignments)
                assignmentScore = assignmentScore + self.assignments(a{1}).totalScore;
            end
            
            assignmentScore = assignmentScore / n;
            
            % weight scores and add up
            self.score = 0.1*(self.selfEvaluationScore + self.peerObservationScore) + 0.8*(assignmentScore);
            score = ceil(self.score); % round up
        end
        %------------------------------------------
    end
    
end