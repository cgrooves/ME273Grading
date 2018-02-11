function [score, feedback] = responseScoreGrader(response)

% check for nonsensical response
if isnan(response)
    score = 0;
else
    score = response;
end

% auto-generate feedback
switch score
    case 0
        feedback = 'No submission';
    case 1
        feedback = 'Does not address objectives';
    case 2
        feedback = 'Minimally addresses objectives';
    case 3
        feedback = 'Merely restates objectives';
    case 4
        feedback = 'Needs more statement of how to improve';
    case 5
        feedback = 'Well done!';
    otherwise
        error('Unknown score assigned');
end

% normalize score
score = score / 5;        

end