function [powers] = computeMotorPower(motors, forces)

    powers.hip = abs(forces(5) * motors.velocity.hip);
    powers.knee = abs(forces(3) * motors.velocity.knee);
    powers.ankle = abs(forces(1) * motors.velocity.ankle);
    powers.hip_knee = abs(forces(4) * motors.velocity.hip_knee);
    powers.knee_ankle = abs(forces(2) * motors.velocity.knee_ankle);   
    
end

