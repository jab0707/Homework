function [Itv,Pe,De] = TVPrimalDualInpaint(I0,mx, sigma,alpha, Niter, epsd,epsp)
mx = double(mx);
wx = zeros(size(I0));
wy = zeros(size(I0));

%I0 = I0/10;

%Calculate the gradient of I0
[Ix,Iy] = grad(I0);
Itv = zeros(size(I0));

 divw = div(wx,wy);
 De = zeros(1,Niter);
 Pe = zeros(1,Niter);
    for k=1:Niter
    %Calculate the gradient with respect to w

    [gdwx,gdwy] = grad(divw);
    
    
    wx = wx + epsd.*(Ix);
    wy = wy + epsd.*(Iy);
    
    %Now project the gradient
    
    nW = sqrt(wx.*wx+wy.*wy);
    nW(nW<1) = 1.0;
    wx = wx./nW;
    wy = wy./nW;
    
    divw = div(wx,wy);
    
    Itv = Itv - epsp*((mx.*(Itv-I0))/sigma - alpha*divw);
    
    
    %Calculate the dual energy
    %%De(k) = sum(sum( (I0-Itv).^2/(2*sigma) - Itv.*divw));
    
    %De(k) = sum(sum((-I0.*divw - 0.5*(divw.*divw)*sigma)));
    % Calculate the primal energy
 
    [Ix,Iy] = grad(Itv);
    
    Pe(k) = sum(sum((I0-Itv).^2/(2*sigma) + sqrt(Ix.*Ix+Iy.*Iy)));
    
    end

    function divf = div(ux,uy)
    divf = (ux - circshift(ux,[1,0])) + (uy - circshift(uy,[0,1]));

    end

    function [ux,uy] = grad(f)
        ux = circshift(f,[-1,0]) - f;
        uy = circshift(f,[0,-1]) - f;
    end
        

Itv = Itv - min(Itv(:));
Itv = Itv/max(Itv(:));
Itv = Itv * 255;
Itv = Itv .* (1-mx);

I0 = I0 - min(I0(:));
I0 = I0/max(I0(:));
I0 = I0*255;

Itv = I0 + Itv;

end