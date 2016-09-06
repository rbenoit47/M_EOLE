function F = gammaFunctions(x)
echo
global Ubar  sigmaU
F = [x(1)*gamma(1+1/x(2))-Ubar; (gamma(1+2/x(2))/gamma(1+1/x(2))^2-1)-(sigmaU/Ubar)^2];
echo
