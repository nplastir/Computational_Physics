
% Cluster growth routine according to Eden model (cancer model)

% Parameters
ngrid = 101; % Number of grid points in each dimension
nwalk = 1000; % Number of walkers
agrd = zeros(ngrid, ngrid); % Initialize the grid

% Initial particle at the center
igrx = floor(ngrid/2) + 1;
igry = floor(ngrid/2) + 1;
agrd(igrx, igry) = 1;

% Loop over the walkers
for i = 1:nwalk
    % Choose a position close to neighbors
    while neighbor(agrd, igrx, igry) == 0
        igrx = floor(ngrid * rand()) + 1;
        igry = floor(ngrid * rand()) + 1;
    end
    agrd(igrx, igry) = 1;
end

% Output cluster configuration
imagesc(agrd);
colormap(); % Set colormap to grayscale
axis equal tight; % Set the axis limits to match the image dimensions
xlabel('X');
ylabel('Y');
title('Cluster Configuration (Eden Model)');
    

function is_neighbor = neighbor(agrd, igrx, igry)
    % Function to check if a given position (igrx, igry) has at least one neighboring
    % position that is already occupied (has a value greater than 0).
    ngrid = size(agrd, 1);
    is_neighbor = 0;

    if agrd(igrx, igry) > 0.5
        return;
    end

    igx1 = igrx - 1;
    igx2 = igrx + 1;
    igy1 = igry - 1;
    igy2 = igry + 1;

    % Wrap-around boundaries
    if igrx == 1
        igx1 = ngrid;
    end
    if igrx == ngrid
        igx2 = 1;
    end
    if igry == 1
        igy1 = ngrid;
    end
    if igry == ngrid
        igy2 = 1;
    end

    if agrd(igx1, igry) > 0.5 || agrd(igx2, igry) > 0.5 || agrd(igrx, igy1) > 0.5 || agrd(igrx, igy2) > 0.5
        is_neighbor = 1;
    end
end
