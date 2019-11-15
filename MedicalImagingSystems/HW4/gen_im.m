function im_out = gen_im(radius, intensity)
% matlab program to randomly place a circle of given radius and intensity 
% on a background of dim x dim image with unity intensity
% usage:  im_out = gen_im(radius, intensity);

dim=256; % output image size

%generate circle
LL=2*radius;
X=(1:LL)/(radius)-1;
XX=X'*ones(1,LL);
YY=ones(LL,1)*X;
RR=XX.*XX+YY.*YY;
circ=ones(LL,LL);
circ(find(RR<=1))=0;

%add circ to image at randomized location

temp=dim-LL;
x0=round(temp*rand(1,1));
y0=round(temp*rand(1,1));

im_out=ones(dim,dim);
im_out(x0:x0+LL-1,y0:y0+LL-1)=circ;
im_out(find(im_out<1))=intensity;