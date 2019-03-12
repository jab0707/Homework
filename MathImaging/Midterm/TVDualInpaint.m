function [Itv,Pe,De] = TVDualInpaint(I0,mx,sigma,alpha,phi,C, Niter, eps)

wx = zeros(size(I0));
wy = zeros(size(I0));
mx = double(mx);
%Calculate constants
Ax = (phi*mx.*I0 + sigma*C)./(phi*mx+sigma);
Bx = (alpha*phi*sigma)./(phi*mx+sigma);
Cx = mx.*Ax - mx.*I0;
Ex = Ax - C;
Fx = ((mx.*Bx)/(2*sigma))-(alpha*Bx) + (Bx.^2)/(2*phi);
Gx = ((Cx.*mx.*Bx)/sigma)-(alpha*Ax)+(Ex.*Bx)/phi;

%Calculate the gradient of I0
[Ix,Iy] = grad(I0);
 divw = div(wx,wy);
 De = zeros(1,Niter);
 Pe = zeros(1,Niter);
    for k=1:Niter
    %Calculate the gradient with respect to w

    [xgdwx,xgdwy] = grad(Fx.*divw);
    [ggxx,ggxy] = grad(Gx);
    
    wx = wx + eps.*(2*(xgdwx)+ggxx);
    wy = wy + eps.*(2*(xgdwy)+ggxy);
    
    %Now project the gradient
    
    nW = sqrt(wx.*wx+wy.*wy);
    nW(nW<1) = 1.0;
    wx = wx./nW;
    wy = wy./nW;
    
    divw = div(wx,wy);
    %Calculate the dual energy
    De(k) = sum(sum((-I0.*divw - 0.5*(divw.*divw)*sigma)));
    % Calculate the primal energy
    Itv = Ax + Bx.*divw;
    [Itx,Ity] = grad(Itv);
    
    Pe(k) = sum(sum( (I0-Itv).^2/(2*sigma) + alpha*sqrt(Itx.*Itx+Ity.*Ity))) + (1/2*phi)*sum(sum(Itv - C));
    
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

