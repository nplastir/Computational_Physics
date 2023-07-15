#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <TMath.h>
#include <TGraph2D.h>
#include <TRandom.h>
#include <TStyle.h>
#include <TCanvas.h>
#include <TF2.h>
#include <TH1.h>
using namespace std;


double Fx(double t, double v_x, double v_y, double v_z, double B_x, double B_y, double B_z){
    double value = (-1.) * (v_y * B_z - v_z * B_y) / 1.  ;
    return value;
}

double Fy(double t, double v_x, double v_y, double v_z, double B_x, double B_y, double B_z){
    double value = (-1.) * (v_z * B_x - v_x * B_z) / 1.  ;
    return value;
}

double Fz(double t, double v_x, double v_y, double v_z, double B_x, double B_y, double B_z){
    double value = (-1.) * (v_x * B_y - v_y * B_x) / 1.  ;
    return value;
}

void Particle(){

    //Initial Conditions
    double x = 0.; double y = 0.; double z = 0.;
    double v_x = 3./2.; double v_y = sqrt(3)/2.; double v_z = sqrt(3);
    double B_x = 0.; double B_y = 0.; double B_z = 4.;
    

    double a_x = 0.; double b_x = 3.; double h_x = 0.1; double N_x =(b_x -a_x)/h_x;
    double a_y = 0.; double b_y = 3.; double h_y = 0.1; double N_y =(b_y -a_y)/h_y;
    double a_z = 0.; double b_z = 3.; double h_z = 0.1; double N_z =(b_z -a_z)/h_z;

    double t[100]; 
    double w_x[100]; double w_y[100]; double w_z[100];
    double w_vx[100]; double w_vy[100]; double w_vz[100];

    t[0] = a_x; 
    w_x[0] = w_y[0] = w_z[0] = w_vx[0] = w_vy[0] = w_vz[0] = 1. ;


    std::ofstream myfile;
    myfile.open ("Particle_Motion.txt");

    for(int i = 0; i <= N_x; i++){

        //Calculate k_1 for position and velocity
        double k1_x = h_x * v_x ;
        double k1_y = h_y * v_y ;
        double k1_z = h_z * v_z ;

        double k1_vx = h_x * Fx(t[i], w_vx[i], v_y , v_z, B_x, B_y, B_z );
        double k1_vy = h_y * Fy(t[i], v_x, w_vy[i] , v_z, B_x, B_y, B_z );
        double k1_vz = h_z * Fz(t[i], v_x, v_y , w_vz[i], B_x, B_y, B_z );

        //Calculate k_2 for position and velocity
        double k2_x = h_x * (v_x + k1_vx / 2);
        double k2_y = h_y * (v_y + k1_vy / 2);
        double k2_z = h_z * (v_z + k1_vz / 2);

        double k2_vx = h_x * Fx(t[i] + h_x/2, w_vx[i] + k1_vx/2, v_y, v_z, B_x, B_y, B_z );
        double k2_vy = h_y * Fy(t[i] + h_y/2, v_x, w_vy[i] + k1_vy/2, v_z, B_x, B_y, B_z );
        double k2_vz = h_z * Fz(t[i] + h_z/2, v_x, v_y, w_vz[i] + k1_vz/2, B_x, B_y, B_z );

        //Calculate k_3 for position and velocity
        double k3_x = h_x * (v_x + k2_vx / 2);
        double k3_y = h_y * (v_y + k2_vy / 2);
        double k3_z = h_z * (v_z + k2_vz / 2);

        double k3_vx = h_x * Fx(t[i] + h_x/2, w_vx[i] + k2_vx/2, v_y, v_z, B_x, B_y, B_z );
        double k3_vy = h_y * Fy(t[i] + h_y/2, v_x, w_vy[i] + k2_vy/2, v_z, B_x, B_y, B_z );
        double k3_vz = h_z * Fz(t[i] + h_z/2, v_x, v_y, w_vz[i] + k2_vz/2, B_x, B_y, B_z );

        //Calculate k_4 for position and velocity
        double k4_x = h_x * (v_x + k3_vx);
        double k4_y = h_y * (v_y + k3_vy);
        double k4_z = h_z * (v_z + k3_vz);

        double k4_vx = h_x * Fx(t[i] + h_x, w_vx[i] + k3_vx, v_y, v_z, B_x, B_y, B_z );
        double k4_vy = h_y * Fy(t[i] + h_y, v_x, w_vy[i] + k3_vy, v_z, B_x, B_y, B_z );
        double k4_vz = h_z * Fz(t[i] + h_z, v_x, v_y, w_vz[i] + k3_vz, B_x, B_y, B_z );

        // Update position and velocity 
        w_x[i+1] = w_x[i] + (k1_x + 2 * k2_x + 2 * k3_x + k4_x) / 6;
        w_y[i+1] = w_y[i] + (k1_y + 2 * k2_y + 2 * k3_y + k4_y) / 6;
        w_z[i+1] = w_z[i] + (k1_z + 2 * k2_z + 2 * k3_z + k4_z) / 6;
        w_vx[i+1] = w_vx[i] + (k1_vx + 2 * k2_vx + 2 * k3_vx + k4_vx) / 6;
        w_vy[i+1] = w_vy[i] + (k1_vy + 2 * k2_vy + 2 * k3_vy + k4_vy) / 6;
        w_vz[i+1] = w_vz[i] + (k1_vz + 2 * k2_vz + 2 * k3_vz + k4_vz) / 6;

        t[i+1] = t[i] + h_x;
        
        cout << t[i] << " " << w_x[i]  << " " << w_y[i]  << " " << w_z[i] << endl;

        myfile << t[i] << " " << w_x[i]  << " " << w_y[i]  << " " << w_z[i] << "\n";

    } 

    myfile.close();


    // Create a canvas to draw the graph
    TCanvas *canvas = new TCanvas("canvas", "Data Graph", 800, 600);

     // Create a graph to plot the data points
    TGraph2D *graph = new TGraph2D();

    graph -> SetMarkerStyle(kFullCircle);
    graph->SetLineColor(kRed);

    fstream file;
    file.open("Particle_Motion.txt", ios::in);

    while(1){
        double time,xcord,ycord,zcord;
        file >> time >> xcord >> ycord >> zcord;
        graph->SetPoint(graph->GetN(), xcord, ycord, zcord);
        if(file.eof()) break;
    }

    file.close();

    // Set the graph options
    graph->SetTitle("Particle Motion;X;Y;Z"); // Replace "X", "Y", "Z" with your desired axis labels

    // Draw the graph on the canvas
    graph->Draw("ALP");

    // Save the canvas as an image file
    canvas->SaveAs("data_graph.png"); // Replace "data_graph.png" with the desired output file name and format


}