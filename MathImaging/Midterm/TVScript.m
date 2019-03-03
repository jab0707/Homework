s = 128;

I = zeros(s,s);
I(s/4:s/4+s/2,s/4:s/4+s/2) = 5;

I0 = I + 1*randn(size(I));
sigma = 1;

figure(1); imagesc(I0);
%colormap('Gray');

%% Now run the TV denoising
Niter = 100;
eps = 0.2;

[Itv,Pe,De] = TVDual(I0, sigma, Niter, eps);


figure(2);
imagesc(Itv)
figure(3); plot(Pe,'r');
hold on; plot(De,'b');

figure; plot(I0(s/2,:),'r'); hold on; plot(Itv(s/2,:),'b')