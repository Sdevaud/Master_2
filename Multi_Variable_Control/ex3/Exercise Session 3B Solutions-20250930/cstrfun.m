function dx=cstrfun(u,q,V,ko,ER,Tf,DH,r,cp,UA)
%
% q:		flow rate            				[L/min]
% V:		reactor volume      				[L]
% ko:       costant 							[1/min]
% ER:       costant      						[K]
% Tf:       input temperature        			[K]
% DH:       molar enthalpy                   	[J/mol]
% r:      	liquid density  					[g/L]
% cp:       specific heat capacity       		[J/gK]
% UA:       heat transfer coefficient * area	[J/minK]
%
%u(1)=c:    concentration in the tank			[mol/L]
%u(2)=T:	temperature in the tank				[K]
%u(3)=cf:   concentration of the inflow     	[mol/L]
%u(4)=Tc:   temperature of the walls			[K]
%
% from the input vector u, we extract the states:
x=u(1:2);
%
% from the input vector u, we extract the inputs to the system:
ui=u(3:4);
%
% We calculate the output:
dx(1)=(q/V)*[ui(1)-x(1)] - ko*[exp(-ER/x(2))]*x(1);
dx(2)=(q/V)*[Tf-x(2)] + [(-DH)/(r*cp)]*ko*[exp(-ER/x(2))]*x(1) + [UA/(V*r*cp)]*[ui(2)-x(2)];

