void plotData()
{
    // Open the data file
    TFile *file = TFile::Open("Particle_Motion.txt"); // Replace "data.txt" with the path to your data file

    // Create a TTree from the data in the file
    TTree *tree = (TTree*)file->Get("data_tree"); // Replace "data_tree" with the name of the TTree in your data file

    // Declare variables to hold the data
    Double_t time, x, y, z;

    // Associate the branches in the TTree with the variables
    tree->SetBranchAddress("time", &time); // Replace "time" with the name of the branch for time
    tree->SetBranchAddress("x", &x);       // Replace "x" with the name of the branch for x coordinate
    tree->SetBranchAddress("y", &y);       // Replace "y" with the name of the branch for y coordinate
    tree->SetBranchAddress("z", &z);       // Replace "z" with the name of the branch for z coordinate

    // Create a canvas to draw the graph
    TCanvas *canvas = new TCanvas("canvas", "Data Graph", 800, 600);

    // Create a graph to plot the data points
    TGraph2D *graph = new TGraph2D(tree->GetEntries());

    // Loop over the entries in the TTree and fill the graph
    for (Long64_t i = 0; i < tree->GetEntries(); i++)
    {
        tree->GetEntry(i);
        graph->SetPoint(i, x, y, z);
    }

    // Set the graph options
    graph->SetTitle("Data Graph;X;Y;Z"); // Replace "X", "Y", "Z" with your desired axis labels

    // Draw the graph on the canvas
    graph->Draw("P");

    // Save the canvas as an image file
    canvas->SaveAs("data_graph.png"); // Replace "data_graph.png" with the desired output file name and format

    // Clean up
    file->Close();
}
