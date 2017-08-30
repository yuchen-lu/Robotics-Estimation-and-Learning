function [ predictx, predicty, state, param ] = kalmanFilter( t, x, y, state, param, previous_t )
%UNTITLED Summary of this function goes here
%   Four dimensional state: position_x, position_y, velocity_x, velocity_y

    %% Place parameters like covarainces, etc. here:
    % P = eye(4)
    % R = eye(2)
    dt=0.033;
    A=[1 0 dt 0; 0 1 0 dt ; 0 0 1 0; 0 0 0 1];
    C=[1 0 0 0; 0 1 0 0];
    % Check if the first time running this function
    if previous_t<0
        state = [x, y, 0, 0];
        param.P = 0.1 * eye(4);
        predictx = x;
        predicty = y;
        return;
    end

    %% TODO: Add Kalman filter updates
    % As an example, here is a Naive estimate without a Kalman filter
    % You should replace this code
    covarm = diag([0.01 0.01 0.1 0.1]);
    covaro = diag([0.01 0.01]);
    
    N1=normpdf(state, [0;0;0;0],covarm);
    Nvx=N1(3,3);
    Nvy=N1(4,4);
    
    vx = state(3) + Nvx;
    vy = state(4) + Nvy;
    % Predict 330ms into the future
    
    N2=normpdf([state(1);state(2)], [0;0],covaro);
    Nx=N2(1,1);
    Ny=N2(2,2);
    predictx = x + Nx;
    predicty = y + Ny;
    % State is a  four dimensional element
    state = [x, y, vx, vy];
end
