b = zeros(size(sinogram,1));
for t = 1:length(thetas)
b = b+BackPropSinogram(sinogram(:,t),deg2rad(thetas(t)),'linearinterp');
figure(1);imshow(b/max(b(:)));title(sprintf('Proj %d',t));drawnow();
end