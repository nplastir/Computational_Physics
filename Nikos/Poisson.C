#include <iostream>
#include <cmath>
#include "TCanvas.h"
#include "TGraph2D.h"
using namespace std;

// Grid and time steps
const int nx = 10;
const int ny = 10;
const int maxstep = 100;

void Poisson() {

    double dx = 0.1;
    double dy = 0.1;

    double x[nx + 1];    
    double y[ny + 1];    

    double C[nx + 1][ny + 1];    // Charge density

    double F[nx + 1][ny + 1];    // Phi

    // Set Initial and Boundary conditions
    for (int i = 0; i <= nx; ++i) {
        x[i] = i * dx;

        for (int j = 0; j <= ny; ++j) {
            y[j] = j * dy;

            // //Constant charge density
            // double charge = 0.0;
            // C[i][j] = charge; 

            // Linear charge density along y-axis
            // C[i][j] = 2.0 * y[j];

            // Charge density represented by a sine wave
            double wavelength = 4.0 * M_PI;
            double amplitude = 1.0;
            C[i][j] = amplitude * sin(wavelength * x[i]);

            if (i == 0 || i == nx || j == 0 || j == ny) {
                F[i][j] = 1.0;  // Boundary condition at the points of if statement
            } else {
                F[i][j] = 0.0;  // Initial value of F=0 everywhere else
            }
        }
    }

    // Loop over the desired steps
    for (int it = 0; it < maxstep; ++it) {
        for (int i = 1; i < nx; ++i) {
            for (int j = 1; j < ny; ++j) {
                double F_new = 0.25 * (F[i + 1][j] + F[i - 1][j] + F[i][j + 1] + F[i][j - 1]) + dx * dy * C[i][j];
                F[i][j] = F_new;
            }
        }
    }

    // Plotting using ROOT
    int numPoints = (nx + 1) * (ny + 1);
    double xValues[numPoints];
    double yValues[numPoints];
    double zValues[numPoints];
    int pointIndex = 0;

    for (int i = 0; i <= nx; ++i) {
        for (int j = 0; j <= ny; ++j) {
            xValues[pointIndex] = x[i];
            yValues[pointIndex] = y[j];
            zValues[pointIndex] = F[i][j];
            ++pointIndex;
        }
    }

    TCanvas canvas("canvas", "Plot of #Phi", 800, 600);
    TGraph2D graph(numPoints, xValues, yValues, zValues);
    graph.SetTitle("Plot of #Phi");
    graph.SetFillColor(38);
    graph.Draw("surf1");

    canvas.Update();
    canvas.SaveAs("FNEW_plot.png");  // Autosave of the canvas

    canvas.WaitPrimitive();     // Command that keeps the canvas active in order to interact
}

int main() {
    Poisson();
    return 0;
}
