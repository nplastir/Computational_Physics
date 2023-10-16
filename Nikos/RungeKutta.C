#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <TH1F.h>
#include <TF1.h>
using namespace std;


double myf(double t, double y){
    double value = 0.5*y;
    return value;
}

void RungeKutta(){
    double wrk4[100]; double t[100];

    double a=0; double b =2;
    double h = 0.5; int N= (b-a)/h;
    t[0]=a; wrk4[0] = 1.;

    std::ofstream myfile;
    myfile.open ("RK4.txt");

    for(int i=0; i<N; i++){
        double k1 = h*myf(t[i], wrk4[i]);
        double k2 = h*myf(t[i] + h/2, wrk4[i] + k1/2);
        double k3 = h*myf(t[i]+ h/2, wrk4[i] + k2/2);
        double k4 = h*myf(t[i]+ h, wrk4[i]+ k3);

        wrk4[i+1] = wrk4[i] + (k1+2*k2+2*k3+k4)/6;
        t[i+1] = t[i] + h;

        cout << t[i] << " " << wrk4[i] << endl;

        myfile << t[i] << " " << wrk4[i] << "\n";
    }

    myfile.close();

    TGraph *gr = new TGraph();

    gr -> SetMarkerStyle(kFullCircle);
    gr->SetLineColor(kBlack);


    fstream file;
    file.open("RK4.txt", ios::in);

    while(1){
        double x,y;
        file >> x >> y;
        gr->SetPoint(gr->GetN(), x,y);
        if(file.eof()) break;
    }

    file.close();

    TCanvas *c1 = new TCanvas();
    gr->Draw("ALP");


    TF1 *func = new TF1("func", "exp(0.5*x)", 0, 2);

    TGraph *graph1 = new TGraph(func);
    graph1->SetLineColor(kBlue);
    graph1->SetLineWidth(2);

    graph1 -> Draw("L SAME");

    c1-> SetTitle("RK4 vs Analytical");

    c1->Update();
    
}

