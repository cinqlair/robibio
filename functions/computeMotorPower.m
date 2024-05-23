function [powers] = computeMotorPower(robot)

    powers.hip = robot.motors.forces.hip * robot.motors.velocity.hip;
    powers.knee = robot.motors.forces.knee * robot.motors.velocity.knee;
    powers.ankle = robot.motors.forces.ankle * robot.motors.velocity.ankle;
    powers.hip_knee = robot.motors.forces.hip_knee * robot.motors.velocity.hip_knee;
    powers.knee_ankle = robot.motors.forces.knee_ankle * robot.motors.velocity.knee_ankle;   
    
end

