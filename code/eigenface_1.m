initial_x = readPoints('dat/107_0764.pts');

x_mean = initial_x;

allFiles = dir('dat/107*.pts');

total = zeros(size(initial_x));

N = length(allFiles);

Xc = zeros(21,136);


for j = 1:10
        
    for iI =1:length(allFiles)
        
        cPts = readPoints( strcat('dat/',allFiles(iI).name ) );
 
        [ptsA,pars] = getAlignedPts( x_mean, cPts );
        
        total = total + ptsA;
        
        %drawFaceParts( -ptsA, 'k-' );
         
    end
    
    x_mean = total./N;
    
    [new_x,pars] = getAlignedPts( initial_x, x_mean );
    
    x_mean = new_x;
    
end

    
for k =1:length(allFiles)
        
    cPts = readPoints( strcat('dat/',allFiles(k).name ) );
 
    [ptsA,pars] = getAlignedPts( x_mean, cPts );
    
    reshaped_X_mean = reshape(x_mean,[136,1]);
    
    single_X = reshape(ptsA,[136,1]) - reshaped_X_mean;
    
    Xc(k,:) = single_X';
       
end

 % covariance matrix
 sigma = cov(Xc);
 
 % find eigen vector and eigen values of covarince matrix
 [eigenVector,eigenValue,~] = eigs(sigma);
 
 The_first_eigenValue = eigenValue(1:1);
 
 z1 = eigenVector(:,1);
 
 The_first_standard_deviation_1 = 2 * sqrt(The_first_eigenValue) * z1; 
 The_first_standard_deviation_2 = 0 * sqrt(The_first_eigenValue) * z1;
 The_first_standard_deviation_3 = -2 * sqrt(The_first_eigenValue) * z1;
 
 The_first_face_element_1 = The_first_standard_deviation_1 + reshaped_X_mean;
 The_first_face_element_2 = The_first_standard_deviation_2 + reshaped_X_mean;
 The_first_face_element_3 = The_first_standard_deviation_3 + reshaped_X_mean;
 
 The_first_face_1 = reshape(The_first_face_element_1,[68,2]);
 The_first_face_2 = reshape(The_first_face_element_2,[68,2]);
 The_first_face_3 = reshape(The_first_face_element_3,[68,2]);
 
 figure(1);drawFaceParts( -The_first_face_1, 'k-' );
 figure(2);drawFaceParts( -The_first_face_2, 'k-' );
 figure(3);drawFaceParts( -The_first_face_3, 'k-' );
 
 
 