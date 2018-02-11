classdef Assignment < handle
    
    properties
        name
        file
        submissionDate
        
        totalScore % 0-1
        totalFeedback 
        codeScore % 0-1
        codeFeedback
        headerScore % 0-1
        headerFeedback
        commentScore % 0-1
        commentFeedback
        
    end
    
    methods
        % Constructor -------------------------------
        function self = Assignment(name)
            
            self.submissionDate = datetime(0,0,0,0,0,0);
            self.name = name;
            self.headerFeedback = 'Assignment not graded; no file submission found';
            self.commentFeedback = 'Assignment not graded; no file submission found';
            self.codeFeedback = 'Assignment not graded; no file submission found';
            self.codeScore = 0;
            self.headerScore = 0;
            self.commentScore = 0;
            self.totalScore = 0;
            self.totalFeedback = 'Assignment not graded; no file submission found';
            
        end
        %--------------------------------------------
        function calculateScore(self,resubmission)
            
            % 30 pts code, 5 pts comments, 5 pts header = 40 pts total
            self.totalScore = ceil(.75*self.codeScore + 0.125*(self.headerScore + self.commentScore));
            
            if resubmission
                self.totalScore = self.totalScore * 0.8;
                self.totalFeedback = 'This grade reflects a 20% penalty for this assignment being resubmitted';
            else
                self.totalFeedback = 'This assignment was submitted on time';
            end
            
        end
        %--------------------------------------------
        
    end
    
end