function [powers] = computeMotorPower(motors, forces)

    powers.hip = forces(5) * motors.velocity.hip;
    powers.knee = forces(3) * motors.velocity.knee;
    powers.ankle = forces(1) * motors.velocity.ankle;
    powers.hip_knee = forces(4) * motors.velocity.hip_knee;
    powers.knee_ankle = forces(2) * motors.velocity.knee_ankle;   
    
end

