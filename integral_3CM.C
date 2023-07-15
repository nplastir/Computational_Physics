#include <iostream>
#include <stdio.h> 
#include <stdlib.h> 
#include <math.h>
using namespace std;


double myfunc(double x, double y, double z){
    double ff=0.;
    ff = (1 + pow(x, 2) + 2 * pow(y, 2) + 3 * pow(z, 2))*(x+y+z);
    return ff;
}

double gaussz(double xx,  double yy, double a, double b, int n1){
    double h1 =(b-a)/n1;
    double integ = 0.;
    for (int i = 0; i< n1; i++){
        double z0 = a + i*h1;
        double z1 = z0 + h1;
        double t[3]={-pow(3./5.,0.5), 0, pow(3./5.,0.5)};
        double z[3]={0.5*((z1-z0)*t[0]+z1+z0), 0.5*((z1-z0)*t[1]+z1+z0), 0.5*((z1-z0)*t[2]+z1+z0)};
        integ += 0.5*(z1-z0)*(myfunc(xx, yy, z[0])/1.8 + myfunc(xx, yy, z[1])/1.125+myfunc(xx, yy, z[2])/1.8);
    }
    return integ;
}

double gaussy(double xx, double a, double b, int n1, int n2){
    double h2 =(b-a)/n2;
    double integ = 0.;
    for (int i = 0; i< n2; i++){
        double y0 = a + i*h2;
        double y1 = y0 + h2;
        double t[3]={-pow(3./5.,0.5), 0, pow(3./5.,0.5)};
        double y_1 = 0.5*((y1-y0)*t[0]+y1+y0);
        double y_2 = 0.5*((y1-y0)*t[1]+y1+y0);
        double y_3 = 0.5*((y1-y0)*t[2]+y1+y0);
        //double y[3]={0.5*((y1-y0)*t[0]+y1+y0), 0.5*((y1-y0)*t[1]+y1+y0), 0.5*((y1-y0)*t[2]+y1+y0)};
        
        integ += 0.5*(y1-y0)*(gaussz(xx, y_1, a, b, n1)/1.8 + gaussz(xx, y_2, a, b, n1)/1.125+gaussz(xx, y_3, a, b, n1)/1.8);
    }
    return integ;
}
void integral_3CM(double a, double b, int n1, int n2, int n3 ){
    double h3 =(b-a)/n3;
    double integ = 0.;
     for (int i = 0; i< n3; i++){
        double x0 = a + i*h3;
        double x1 = x0 + h3;
        double t[3]={-pow(3./5.,0.5), 0, pow(3./5.,0.5)};
        double x_1 = 0.5*((x1-x0)*t[0]+x1+x0);
        double x_2 = 0.5*((x1-x0)*t[1]+x1+x0);
        double x_3 = 0.5*((x1-x0)*t[2]+x1+x0);
        //double x[3]={0.5*((x1-x0)*t[0]+x1+x0), 0.5*((x1-x0)*t[1]+x1+x0), 0.5*((x1-x0)*t[2]+x1+x0)};
        integ += 0.5*(x1-x0)*(gaussy(x_1, a, b, n1, n2)/1.8 + gaussy(x_2, a, b, n1, n2)/1.125+gaussy(x_3, a, b, n1, n2)/1.8);
    }

    printf("Integral is %3.12f ", integ);
}