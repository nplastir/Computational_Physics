#include <iostream>
#include <cmath>
#include "TCanvas.h"
#include "TGraph.h"
#include "TPolyLine3D.h"

// Function to calculate the Lorentz force
void lorentz_force(double charge, const double* velocity, const double* magnetic_field, double* force) {
    force[0] = charge * (velocity[1] * magnetic_field[2] - velocity[2] * magnetic_field[1]);
    force[1] = charge * (velocity[2] * magnetic_field[0] - velocity[0] * magnetic_field[2]);
    force[2] = charge * (velocity[0] * magnetic_field[1] - velocity[1] * magnetic_field[0]);
}

// Function to update position and velocity using the fourth-order Runge-Kutta method
void runge_kutta_method(double* position, double* velocity, const double* magnetic_field, double charge, double mass, double time_step) {
    double k1_pos[3], k2_pos[3], k3_pos[3], k4_pos[3];
    double k1_vel[3], k2_vel[3], k3_vel[3], k4_vel[3];

    // Calculate k1 values
    double k1_force[3];
    lorentz_force(charge, velocity, magnetic_field, k1_force);
    for (int i = 0; i < 3; i++) {
        k1_pos[i] = velocity[i] * time_step;
        k1_vel[i] = k1_force[i] / mass * time_step;
    }

    // Calculate k2 values
    double temp_pos[3], temp_vel[3];
    for (int i = 0; i < 3; i++) {
        temp_pos[i] = position[i] + k1_pos[i] / 2;
        temp_vel[i] = velocity[i] + k1_vel[i] / 2;
    }
    double k2_force[3];
    lorentz_force(charge, temp_vel, magnetic_field, k2_force);
    for (int i = 0; i < 3; i++) {
        k2_pos[i] = temp_vel[i] * time_step;
        k2_vel[i] = k2_force[i] / mass * time_step;
    }

    // Calculate k3 values
    for (int i = 0; i < 3; i++) {
        temp_pos[i] = position[i] + k2_pos[i] / 2;
        temp_vel[i] = velocity[i] + k2_vel[i] / 2;
    }
    double k3_force[3];
    lorentz_force(charge, temp_vel, magnetic_field, k3_force);
    for (int i = 0; i < 3; i++) {
        k3_pos[i] = temp_vel[i] * time_step;
        k3_vel[i] = k3_force[i] / mass * time_step;
    }

    // Calculate k4 values
    for (int i = 0; i < 3; i++) {
        temp_pos[i] = position[i] + k3_pos[i];
        temp_vel[i] = velocity[i] + k3_vel[i];
    }
    double k4_force[3];
    lorentz_force(charge, temp_vel, magnetic_field, k4_force);
    for (int i = 0; i < 3; i++) {
        k4_pos[i] = temp_vel[i] * time_step;
        k4_vel[i] = k4_force[i] / mass * time_step;
    }

    // Update position and velocity using the Runge-Kutta method
    for (int i = 0; i < 3; i++) {
        position[i] += (k1_pos[i] + 2 * k2_pos[i] + 2 * k3_pos[i] + k4_pos[i]) / 6;
        velocity[i] += (k1_vel[i] + 2 * k2_vel[i] + 2 * k3_vel[i] + k4_vel[i]) / 6;
    }
}

int main() {
    const double charge = 1.6e-19;  // Charge of the particle (in coulombs)
    const double mass = 9.1e-31;    // Mass of the particle (in kilograms)
    double initial_position[3] = {0.0, 0.0, 0.0};   // Initial position (in meters)
    double initial_velocity[3] = {1e4, 0.0, 0.0};   // Initial velocity (in meters per second)
    const double magnetic_field[3] = {0.0, 0.0, 1.0};      // Magnetic field (in tesla)
    const double time_step = 1e-9;    // Time step for numerical integration (in seconds)
    const int num_steps = 1000;       // Number of time steps to simulate

    double positions[num_steps + 1][3];
    double velocities[num_steps + 1][3];

    // Initialize the position and velocity arrays
    for (int i = 0; i < 3; i++) {
        positions[0][i] = initial_position[i];
        velocities[0][i] = initial_velocity[i];
    }

    // Simulate the motion using the Runge-Kutta method
    for (int step = 0; step < num_steps; step++) {
        runge_kutta_method(positions[step], velocities[step], magnetic_field, charge, mass, time_step);
    }

    // Create TPolyLine3D for plotting the trajectory
    TPolyLine3D* polyline = new TPolyLine3D(num_steps + 1);
    for (int i = 0; i <= num_steps; i++) {
        polyline->SetPoint(i, positions[i][0], positions[i][1], positions[i][2]);
    }

    // Create canvas and draw the trajectory
    TCanvas* canvas = new TCanvas("canvas", "Particle Motion", 800, 600);
    polyline->Draw();

    // Save canvas to a file
    canvas->SaveAs("particle_motion.root");

    delete polyline;
    delete canvas;

    return 0;
}
