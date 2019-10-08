function [cai]=conc_buffer(ca_t,a1,b1,a2,b2)


 	alp2 = a1+a2+b1+b2-ca_t;
	alp1 = b1*b2 -ca_t.*(b1+b2)+a1*b2+a2*b1;
	alp0 = -b1*b2*ca_t;
      Q=(3*alp1-alp2.^2)/9;
      R=(9*alp2.*alp1-27*alp0-2*alp2.^3)/54;
      T=(R + (Q.^3 + R.^2).^0.5).^(1/3) -Q./((R + (Q.^3 + R.^2).^0.5).^(1/3));
       
     cai =abs(T-alp2/3);