function lateWeight = getLateWeight(dueDate,subDate,section)

    % get difference (in hours) between dueDate and submission time
    adjustedDate = dueDate + section - 1; % adjust for section number
    d = subDate - adjustedDate;

    if d > duration(96,0,0)
        lateWeight = 0;
    elseif d > duration(72,0,0)
        lateWeight = 0.2;
    elseif d > duration(48,0,0)
        lateWeight = 0.4;
    elseif d > duration(24,0,0)
        lateWeight = 0.6;
    elseif d > duration(0,0,0)
        lateWeight = 0.8;
    else
        lateWeight = 1;
    end
            
end