% set the mean to the first point set
% align all x(i) to x(u)
% calculate the new meean
% align x(u) to x(1)
% go to align unless x(u) has converged
initial_x = readPoints('dat/107_0764.pts');

x_mean = initial_x;

allFiles = dir('dat/107*.pts');

total = zeros(size(initial_x));

energy = zeros(1,10);

N = length(allFiles);

for j = 1:10
    
    total_energy = 0;
    
    for iI =1:length(allFiles)
        
        cPts = readPoints( strcat('dat/',allFiles(iI).name ) );
 
        [ptsA,pars] = getAlignedPts( x_mean, cPts );
        
        single_energy = norm(x_mean - ptsA).^2;
        
        total = total + ptsA;
        
        drawFaceParts( -ptsA, 'k-' );
  
        total_energy = single_energy + total_energy;
        
    end
    
    x_mean = total./N;
    
    [new_x,pars] = getAlignedPts( initial_x, x_mean );
    
    x_mean = new_x;
    
    energy(j) = total_energy;
  
end
  
  figure;plot(energy);
 