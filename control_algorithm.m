%{ 
Original 
% Function: [M T] = control_algorithm(t, q, w, h)
% Programmed by:
% Date: 

function [M T] = control_algorithm(t, q, w, h, Bb)

% Inputs:
%    t = time
%    q = attitude quaternion with respect to the orbital frame (4-element vector)
%    w = rotation rates in body frame (3-element vector)
%    h = accumulated momentum in the wheels (3-element vector)
%    Bb = magnetic field in body frame (3-element vector)

% Outputs:
%    M = commanded magnetic dipole moment (3-element vector)
%    T = commanded torque for the momentum wheels (3-element vector)

% Global variable: user defined... 
global v1 v2 v3

% Default output
M = [0 0 0]';
T = [0 0 0]';

%}

%Programmed by: 6943841

%for Magnetorquer
function [M, T] = control_algorithm(t,q,w,h,Bb)

%Column Vector
Bb=Bb(:);

%Store previous magnetic field
persistent B_prev t_prev
% Initialize previous values if they are empty
if isempty(B_prev)
    B_prev = Bb;
    t_prev = t;
end
%time step
dt = t - t_prev;

%Compute B-dot
if dt<=[0;0;0]
    dB=[0;0;0];
else
    dB=(Bb-B_prev)/dt;
end

%controller gain
k=5e4;
%B-dot Control law
M=-k*dB;
%Dipole saturation limit given 
Mmax=1;
M=max(min(M,Mmax),-Mmax);

%Reaction wheels off
T=[0;0;0];

%Update stored values
B_prev=Bb;
t_prev=t;

end

%{
%For Reaction Wheel
function [M, T] = control_algorithm(t,q,w,h,Bb)

%Magnetorquer off for reaction wheel
M=[0;0;0];
%Damping Gain
Kd=1e-4;
%Calculating rate damping control
T=Kd*w;
%Torque saturation limit given in the assignment
Tmax=0.003;

T=max(min(T,Tmax),-Tmax);

%Wheel Momentum Saturation
hmax=0.05;

if any(abs(h)>=hmax)
    %Reset torque 
    T=[0;0;0];
end

end

%}