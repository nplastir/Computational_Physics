#include <stdio.h>
#include <math.h>

#define NX 100 // Number of grid points
#define LX 10.0 // Length of domain
#define NSTEP 100 // Number of time steps
#define DT 0.1 // Time step size
#define DX LX/(NX-1) // Grid spacing

int Leapfrog() {
    double V = 1.0; // Wave speed
    double COEF = -V*DT/DX; // The coefficient used in leapfrog scheme

    // Set Initial and Boundary conditions
    double SIGMA = 0.1; // Width of gaussian pulse
    double KWAVE = M_PI/SIGMA; // Wave number
    double X[NX];
    double A_OLD[NX], A[NX], A_NEW[NX];
    double TIME = 0.0;

    for (int i = 0; i < NX; i++) {
        X[i] = (-LX/2.0) + i*DX; // x-coordinates

        // Initial state of a gaussian cosine pulse
        A_OLD[i] = cos(KWAVE*X[i])*exp(-0.5*pow(X[i]/SIGMA, 2));
    }

    // First time step (Two time steps needed in leapfrog method)
    A[0] = 0.5*(A_OLD[1] + A_OLD[NX-1])
           + 0.5*COEF*(A_OLD[1] - A_OLD[NX-1]);
    for (int i = 1; i < NX-1; i++) {
        A[i] = 0.5*(A_OLD[i+1] + A_OLD[i-1])
               + 0.5*COEF*(A_OLD[i+1] - A_OLD[i-1]);
    }
    A[NX-1] = 0.5*(A_OLD[0] + A_OLD[NX-2])
               + 0.5*COEF*(A_OLD[0] - A_OLD[NX-2]);

    for (int it = 1; it <= NSTEP; it++) {
        // Periodic boundary conditions
        A_NEW[0] = A_OLD[0] + COEF*(A[1] - A[NX-1]);

        // Use staggered Leapfrog relation
        for (int i = 1; i < NX-1; i++) {
            A_NEW[i] = A_OLD[i] + COEF*(A[i+1] - A[i-1]);
        }

        A_NEW[NX-1] = A_OLD[NX-1] + COEF*(A[0] - A[NX-2]);

        // Update old solution
        for (int i = 0; i < NX; i++) {
            A_OLD[i] = A[i];
            A[i] = A_NEW[i];
        }

        TIME += DT;
    }

    return 0;
}
