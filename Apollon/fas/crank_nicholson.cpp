#define x_steps 500
#define t_steps 200
#define gauss_seidel_iterations 30

void crank_nicholson() {
    double mean = 40, sigma = 10, wf2[x_steps];

    TComplex
        im(0, 1), // imaginary unit
        space_step(1), time_step(1),
        lambda(TComplex(2) * space_step * space_step / time_step), V_height(100),
        A_diagonal[x_steps], B_diagonal[x_steps], V[x_steps], b[x_steps], wf[x_steps];
    
    for(int i = 0; i < x_steps/2; i++) { V[i] = 0; }
    for(int i = x_steps/2; i < x_steps; i++) { V[i] = V_height; }

    for(int i = 0; i < x_steps; i++) {
        A_diagonal[i] = im * lambda - space_step * space_step * V[i] - TComplex(2);
        B_diagonal[i] = im * lambda + space_step * space_step * V[i] + TComplex(2);

        wf[i] = TComplex::Exp(im * TComplex(i)) * TComplex(
            exp(-0.5 * pow((i - mean) / (sigma + 0.), 2))
        ); // gaussian wavepacket
    }

    TCanvas *canvas = new TCanvas("crank_nicholson");

    for(int i = 0; i < t_steps; i++) {
        // matrix multiplication: b = B * wf
        b[0] = B_diagonal[0] * wf[0] - wf[1];
        for(int j = 1; j < (x_steps - 1); j++) {
            b[j] = - wf[j-1] + B_diagonal[j] * wf[j] - wf[j+1];
        }
        b[x_steps-1] = - wf[x_steps-2] + B_diagonal[x_steps-1] * wf[x_steps-1];

        // solving the system A * wf = b using Gauss-Seidel
        for(int iter = 0; iter < gauss_seidel_iterations; iter++) {
            wf[0] = (b[0] - wf[1]) / A_diagonal[0];
            for(int j = 1; j < (x_steps - 1); j++) {
                wf[j] = (b[j] - wf[j-1] - wf[j+1]) / A_diagonal[j];
            }
            wf[x_steps-1] = (b[x_steps-1] - wf[x_steps-1]) / A_diagonal[x_steps-1];
        }

        // calculating |ψ|^2
        for(int j = 0; j < x_steps; j++) {
            wf2[j] = (TComplex::Conjugate(wf[j]) * wf[j]).Re();
        }
    }
}