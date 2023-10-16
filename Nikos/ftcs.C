#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <TH1F.h>
using namespace std; 

void ftcs(double h, double dt){
    const int nx = 1. /h+1;
    TH2F *his = new TH2F("his", " ", nx, 0., 1., 100, 0., 1.);
    double T[nx], T_new[nx];
    double time = 0; int nt =10./dt;
    double k=0.52;

    double ksi = k*dt/(h*h);

    cout << ksi << endl;

    for(int i=0; i< nx; i++){  //initial condition
        T[i] = 100.;
    }   

    T[0] = 0., T[nx-1] = 0.;   //boundary conditions

    for ( int it =1; it < nt; it++){
        for(int i =1; i< nx; i++){ 
            T_new[i] = T[i] + ksi* (T[i+1] + T[i-1] - 2*T[i]);
        }
        for(int i =1; i< nx; i++){ 
            T[i] = T_new[i];
        }

        if(it%10==0){
            for(int i= 0; i< nx; i++){
                his -> SetBinContent(i+1, it/10+1, T[i]);
            }
        }
    }
    his-> Draw("surf3");
}