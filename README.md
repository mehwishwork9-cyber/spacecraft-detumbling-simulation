# CubeSat Attitude Detumbling Simulation

**MATLAB | Spacecraft Attitude Dynamics | AOCS | B-dot Control | Reaction Wheels**

## Project Overview

This project investigates spacecraft attitude detumbling using two attitude control approaches: **magnetorquer-based B-dot control** and **reaction-wheel rate damping**.

A CubeSat may experience unwanted rotational motion following deployment, making detumbling an important initial step before achieving stable attitude pointing.

The project uses MATLAB to simulate spacecraft rotational dynamics, implement control algorithms, and evaluate their effectiveness in reducing angular velocity.

## Project Objectives

- Model CubeSat rotational dynamics using Euler's rigid-body equations.
- Represent spacecraft attitude using quaternions.
- Implement a B-dot detumbling controller using magnetorquers.
- Implement a reaction-wheel rate-damping controller.
- Evaluate angular velocity reduction and settling behaviour.
- Investigate actuator limitations and the influence of sensor measurement noise.
- Compare the effectiveness and limitations of both control approaches.

## Mathematical Modelling

### Spacecraft Rotational Dynamics

The spacecraft rotational motion is modelled using Euler's rigid-body equation:

\[
\mathbf{I}\dot{\boldsymbol{\omega}}+
\boldsymbol{\omega}\times(\mathbf{I}\boldsymbol{\omega})
=\boldsymbol{\tau}
\]

Where:

- **I** – Spacecraft moment of inertia matrix.
- **ω** – Spacecraft angular velocity vector.
- **ω̇** – Angular acceleration.
- **τ** – Applied control torque.

Quaternion kinematics are used to represent spacecraft orientation without the singularities associated with Euler angles.

### B-dot Magnetorquer Controller

The B-dot controller uses the measured rate of change of the magnetic field in the spacecraft body frame to generate a damping command.

\[
\mathbf{m}=-k\dot{\mathbf{B}}
\]

Where:

- **m** – Commanded magnetic dipole moment.
- **k** – B-dot controller gain.
- **Ḃ** – Rate of change of the measured magnetic field.

The control torque produced by the magnetorquers is:

\[
\boldsymbol{\tau}=\mathbf{m}\times\mathbf{B}
\]

Magnetorquers can only generate torque perpendicular to the local magnetic field, limiting instantaneous control authority.

### Reaction-Wheel Rate Damping

A proportional angular-rate controller is used to command damping torque:

\[
\boldsymbol{\tau}_{cmd}=-K_d\boldsymbol{\omega}
\]

Where:

- **τcmd** – Desired spacecraft control torque.
- **Kd** – Angular-rate damping gain.
- **ω** – Spacecraft angular velocity.

The simulation evaluates rotational damping while considering reaction-wheel torque and momentum-storage limits.

## Simulation Setup

| Parameter | Value |
|---|---|
| Simulation environment | MATLAB |
| Numerical solver | ODE45 |
| Initial angular velocity | [1, 2, 3] rad/s |
| Initial quaternion | [0, 0, 0, 1] (scalar-last) |
| Moment of inertia | Diagonal matrix, 0.0018 kg·m² on each axis |
| B-dot controller gain | 5 × 10⁴ |
| Initial magnetic field | [3 × 10⁻⁵, 3 × 10⁻⁵, 3 × 10⁻⁵] T |
| Reaction-wheel maximum torque | 0.003 N·m |
| Reaction-wheel momentum capacity | 0.05 N·m·s |
| Reaction-wheel damping gain | 1 × 10⁻⁴ |
| B-dot simulation duration | 10,000 s |
| Reaction-wheel simulation duration | 350 s |

## Results and Performance

### 1. B-dot Magnetorquer Control

The B-dot controller was simulated over 10,000 seconds to assess its ability to reduce spacecraft angular velocity.

**Observed results:**

- Initial angular velocity magnitude: approximately **3.742 rad/s**
- Final angular velocity magnitude: approximately **3.39 rad/s**
- Total angular velocity reduction: approximately **9%**
- The tested B-dot configuration achieved limited detumbling performance.

The results demonstrate the challenges of magnetic-only control, including limited instantaneous control authority and sensitivity to the assumed magnetic-field model and controller gain.

### 2. Reaction-Wheel Rate Damping

The reaction-wheel controller was simulated over 350 seconds.

**Observed results:**

- Initial angular velocity magnitude: approximately **3.742 rad/s**
- Angular velocity reduced below **0.01 rad/s**
- Target angular velocity reached at approximately **280–300 seconds**
- No actuator saturation was observed in the simulated case.

Reaction-wheel control achieved substantially faster angular-rate reduction than the tested B-dot configuration.

### 3. Sensor Noise Assessment

The simulation also examined the influence of measurement noise.

- Gyroscope noise standard deviation: **0.01 rad/s**
- Magnetometer noise standard deviation: **1 × 10⁻⁶ T**

The tested noise levels produced negligible changes in the reported detumbling performance.

## Key Findings

- Reaction-wheel damping achieved significantly faster angular-velocity reduction than the tested B-dot controller.
- The B-dot simulation demonstrated the limitations of magnetorquer-based control under the selected modelling assumptions and gain.
- Actuator torque and momentum limits are important considerations in spacecraft attitude control.
- Numerical simulation provides a useful environment for assessing controller behaviour and comparing control strategies.

## Tools and Technologies

- **MATLAB** – Mathematical modelling, simulation and visualisation.
- **ODE45** – Numerical integration of spacecraft rotational dynamics.
- **Quaternion kinematics** – Spacecraft attitude representation.
- **B-dot control** – Magnetic detumbling.
- **Reaction-wheel control** – Angular-rate damping.
- **Control-system performance analysis** – Angular velocity, settling behaviour, noise sensitivity and actuator constraints.

## Limitations and Future Improvements

The project uses a simplified CubeSat dynamics and magnetic-field model. The results should be interpreted as a comparison under the selected simulation conditions rather than a general comparison of magnetorquer and reaction-wheel performance.

Potential future improvements include:

- Implementing an orbit-dependent geomagnetic field model.
- Investigating systematic B-dot gain selection and optimisation.
- Modelling magnetorquer dipole saturation.
- Extending reaction-wheel modelling to include realistic wheel-speed dynamics.
- Implementing sensor bias and more detailed measurement-noise models.
- Integrating an attitude estimator using an Extended Kalman Filter.
- Evaluating closed-loop attitude pointing following detumbling.

## Author

**Mehwish Akram**

MSc Astronautics & Space Engineering

**Areas of Interest:** Attitude Determination and Control Systems (ADCS), Guidance, Navigation and Control (GNC), Spacecraft Dynamics, Numerical Simulation and Space Systems Engineering.
