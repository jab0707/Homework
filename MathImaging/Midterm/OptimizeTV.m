function [Iest, SigAlphas,Is, energy] = OptimizeTV(Truth,I0,mx, s1,a1, TVIter, OptIter, epsd,epsp,epsas,epsdecay)
%OPTMIMIZETV Summary of this function goes here
%   Detailed explanation goes here

Is = zeros(size(I0,1),size(I0,2),OptIter +3);
mx = abs(mx);
SigAlphas = zeros(2,3+OptIter);
energy = zeros(1,3+OptIter);
s = s1;
a = a1;

%
tic
[Iest,~,~] = TVPrimalDualInpaint(I0,abs(mx-1), s,a, TVIter, epsd,epsp);
fprintf('Initilization 1/3 done. ');toc
Is(:,:,1) = Iest;
SigAlphas(1,1) = s;
SigAlphas(2,1) = a;
maskedD = mx.*Iest;
maskedI = mx.*Truth;
energy(1) = sum(sum(abs(maskedD-maskedI)));

s = s + epsas;
a = a + epsas;
%
tic
[Iest,~,~] = TVPrimalDualInpaint(I0,abs(mx-1), s,a, TVIter, epsd,epsp);
fprintf('Initilization 2/3 done. ');toc
Is(:,:,2) = Iest;
SigAlphas(1,2) = s;
SigAlphas(2,2) = a;
maskedD = mx.*Iest;
maskedI = mx.*Truth;
energy(2) = sum(sum(abs(maskedD-maskedI)));

s = s1;
a = a1 + epsas;
%
tic
[Iest,~,~] = TVPrimalDualInpaint(I0,abs(mx-1), s,a, TVIter, epsd,epsp);
fprintf('Initilization 3/3 done. ');toc
Is(:,:,3) = Iest;
SigAlphas(1,3) = s;
SigAlphas(2,3) = a;
maskedD = mx.*Iest;
maskedI = mx.*Truth;
energy(3) = sum(sum(abs(maskedD-maskedI)));

currentTriangle = 1:3;
[~,idx] = max(energy(currentTriangle));
otherInds = setdiff(currentTriangle,currentTriangle(idx));
newDir = sum(SigAlphas(:,otherInds)-SigAlphas(:,currentTriangle(idx)),2)/2;
currentTriangle = [otherInds,4];

for i = 1:OptIter
    tic
    newSigAlpha = SigAlphas(:,currentTriangle(idx))+newDir + (newDir/norm(newDir))*eps + [rand()*.1;rand()*.1];
    SigAlphas(:,i+3) = newSigAlpha;
    
    [Iest,~,~] = TVPrimalDualInpaint(I0,abs(mx-1), newSigAlpha(1),newSigAlpha(2), TVIter, epsd,epsp);
    Is(:,:,i+3) = Iest;
    maskedD = mx.*Iest;
    energy(i+3) = sum(sum(abs(maskedD-maskedI)));
    
    
    [~,idx] = max(energy(currentTriangle));
    otherInds = setdiff(currentTriangle,currentTriangle(idx));
    newDir = sum(SigAlphas(:,otherInds)-SigAlphas(:,currentTriangle(idx)),2)/2;
    currentTriangle = [otherInds,i+4];
    epsas = epsas - epsdecay;
    fprintf(['For iteration ',num2str(i),' the ']);
    toc
end



end
