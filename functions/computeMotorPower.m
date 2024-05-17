function [powers] = computeMotorPower(robot)

    powers.hip = robot.motors.forces(5) * robot.motors.velocity.hip;
    powers.knee = robot.motors.forces(3) * robot.motors.velocity.knee;
    powers.ankle = robot.motors.forces(1) * robot.motors.velocity.ankle;
    powers.hip_knee = robot.motors.forces(4) * robot.motors.velocity.hip_knee;
    powers.knee_ankle = robot.motors.forces(2) * robot.motors.velocity.knee_ankle;   
    
end

