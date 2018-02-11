classdef Student < handle
   
    properties
       firstName
       lastName
       BYUID
       last4
       netID
       email
       labs
       section
    end
    
    methods
        % Constructor ------------------------------
        function self = Student
            self.labs = containers.Map;
        end
        %-------------------------------------------

    end
    
end