function fill_gauss_poly1()
    N = 100;
    hB = histogram('BinEdges', 0:100, 'BinCounts', zeros(1, N));
    hSB = histogram('BinEdges', 0:100, 'BinCounts', zeros(1, N));

    fB = @(x) 1 - 0.01 * x;
    fS = @(x) exp(-(x - 33).^2 / (2 * 2^2));

    dataB = random(fB, 1, 20000);
    dataS = random(fS, 1, 10000);

    hSB.Data = [dataB, dataS];
    histogram(hSB);

    binContents = hSB.Values;
    disp(binContents);
end
