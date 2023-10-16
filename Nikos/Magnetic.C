#include <iostream>
#include <cmath>
#include "TCanvas.h"
#include "TPolyLine3D.h"

// Function to calculate the Lorentz force
void lorentz_force(double charge, const double* velocity, const double* magnetic_field, double* force) {
    force[0] = charge * (velocity[1] * magnetic_field[2] - velocity[2] * magnetic_field[1]);
    force[1] = charge * (velocity[2] * magnetic_field[0] - velocity[0] * magnetic_field[2]);
    force[2] = charge * (velocity[0] * magnetic_field[1] - velocity[1] * magnetic_field[0]);
}

// Function to update position and velocity using the fourth-order Runge-Kutta method
void runge_kutta_method(double& x, double& y, double& z,
                        double& v_x, double& v_y, double& v_z,
                        const double* magnetic_field, double charge, double mass, double time_step) {
    double k1_x, k1_y, k1_z;
    double k2_x, k2_y, k2_z;
    double k3_x, k3_y, k3_z;
    double k4_x, k4_y, k4_z;

    double k1_vx, k1_vy, k1_vz;
    double k2_vx, k2_vy, k2_vz;
    double k3_vx, k3_vy, k3_vz;
    double k4_vx, k4_vy, k4_vz;

    // Calculate k1 values
    double k1_force[3];
    lorentz_force(charge, new double[3]{v_x, v_y, v_z}, magnetic_field, k1_force);
    k1_x = v_x * time_step;
    k1_y = v_y * time_step;
    k1_z = v_z * time_step;
    k1_vx = k1_force[0] / mass * time_step;
    k1_vy = k1_force[1] / mass * time_step;
    k1_vz = k1_force[2] / mass * time_step;

    // Calculate k2 values
    double temp_x = x + k1_x / 2;
    double temp_y = y + k1_y / 2;
    double temp_z = z + k1_z / 2;
    double temp_vx = v_x + k1_vx / 2;
    double temp_vy = v_y + k1_vy / 2;
    double temp_vz = v_z + k1_vz / 2;
    double k2_force[3];
    lorentz_force(charge, new double[3]{temp_vx, temp_vy, temp_vz}, magnetic_field, k2_force);
    k2_x = temp_vx * time_step;
    k2_y = temp_vy * time_step;
    k2_z = temp_vz * time_step;
    k2_vx = k2_force[0] / mass * time_step;
    k2_vy = k2_force[1] / mass * time_step;
    k2_vz = k2_force[2] / mass * time_step;

    // Calculate k3 values
    temp_x = x + k2_x / 2;
    temp_y = y + k2_y / 2;
    temp_z = z + k2_z / 2;
    temp_vx = v_x + k2_vx / 2;
    temp_vy = v_y + k2_vy / 2;
    temp_vz = v_z + k2_vz / 2;
    double k3_force[3];
    lorentz_force(charge, new double[3]{temp_vx, temp_vy, temp_vz}, magnetic_field, k3_force);
    k3_x = temp_vx * time_step;
    k3_y = temp_vy * time_step;
    k3_z = temp_vz * time_step;
    k3_vx = k3_force[0] / mass * time_step;
    k3_vy = k3_force[1] / mass * time_step;
    k3_vz = k3_force[2] / mass * time_step;

    // Calculate k4 values
    temp_x = x + k3_x;
    temp_y = y + k3_y;
    temp_z = z + k3_z;
    temp_vx = v_x + k3_vx;
    temp_vy = v_y + k3_vy;
    temp_vz = v_z + k3_vz;
    double k4_force[3];
    lorentz_force(charge, new double[3]{temp_vx, temp_vy, temp_vz}, magnetic_field, k4_force);
    k4_x = temp_vx * time_step;
    k4_y = temp_vy * time_step;
    k4_z = temp_vz * time_step;
    k4_vx = k4_force[0] / mass * time_step;
    k4_vy = k4_force[1] / mass * time_step;
    k4_vz = k4_force[2] / mass * time_step;

    // Update position and velocity using the Runge-Kutta method
    x += (k1_x + 2 * k2_x + 2 * k3_x + k4_x) / 6;
    y += (k1_y + 2 * k2_y + 2 * k3_y + k4_y) / 6;
    z += (k1_z + 2 * k2_z + 2 * k3_z + k4_z) / 6;
    v_x += (k1_vx + 2 * k2_vx + 2 * k3_vx + k4_vx) / 6;
    v_y += (k1_vy + 2 * k2_vy + 2 * k3_vy + k4_vy) / 6;
    v_z += (k1_vz + 2 * k2_vz + 2 * k3_vz + k4_vz) / 6;
}

int main() {
    const double charge = 1.6e-19;  // Charge of the particle (in coulombs)
    const double mass = 9.1e-31;    // Mass of the particle (in kilograms)
    double x = 0.0;   // Initial position x-coordinate (in meters)
    double y = 0.0;   // Initial position y-coordinate (in meters)
    double z = 0.0;   // Initial position z-coordinate (in meters)
    double v_x = 1e4;   // Initial velocity x-component (in meters per second)
    double v_y = 0.0;   // Initial velocity y-component (in meters per second)
    double v_z = 0.0;   // Initial velocity z-component (in meters per second)
    const double magnetic_field_x = 0.0;    // Magnetic field x-component (in tesla)
    const double magnetic_field_y = 0.0;    // Magnetic field y-component (in tesla)
    const double magnetic_field_z = 1.0;    // Magnetic field z-component (in tesla)
    const double time_step = 1e-9;    // Time step for numerical integration (in seconds)
    const int num_steps = 1000;       // Number of time steps to simulate

    // Create TPolyLine3D for plotting the trajectory
    TPolyLine3D* polyline = new TPolyLine3D(num_steps + 1);

    // Simulate the motion using the Runge-Kutta method and add points to the TPolyLine3D
    for (int step = 0; step <= num_steps; step++) {
        polyline->SetPoint(step, x, y, z);
        runge_kutta_method(x, y, z, v_x, v_y, v_z,
                           new double[3]{magnetic_field_x, magnetic_field_y, magnetic_field_z},
                           charge, mass, time_step);
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
