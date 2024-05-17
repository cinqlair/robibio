%% Motor P02-23Sx80F model
% motorLength is the slider stroke in mm (origin is the motor base)
% sliderLength is the slider length in mm [130 | 150 | 170 | 200 | 230 |
% 270 ...]

%% Output
% force is the maximum motor force 
% state is the motor state 
% - 0 => the stroke is too far inside the stator (force = 0)
% - 1 => inside ramp
% - 2 => nominal state
% - 3 => outside ramp
% - 4 => the stroke is too far outside the stator (force = 0)
function [force, state] = P02_23x80F_HP(motorLength, sliderLength) 


% Doc @ https://shop.linmot.com/data/import/Dokumente/0185-1008-E_1V2_DS_Linear_Motors_P02-23Sx80F-HP.pdf


    % Estimate weight
    %weight = 0.852*sliderLength - 17.1;
    
    % Points P1, P2, P3 and P4
    P1 = 95;
    P2 = 119;
    P3 = sliderLength - 11;
    P4 = sliderLength + 19;
    
    
    
    if (motorLength<P1)
        force = 0;
        state = 0;
        return
    end
    
    
    if (motorLength<=P2)
        force = 0.8242*motorLength-30.9838;
        state = 1;
        return 
    end
    
    if (motorLength<=P3)
        force = 67.1;
        state = 2;
        return;
    end
    
    if (motorLength<=P4)
        force = -0.8242*motorLength + 67.1+0.8242*P3;
        state = 3;
        return
    end

    if (motorLength>P4)
        force = 0;
        state = 4;
        return
    end
end