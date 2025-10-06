%FILE CSTR_eq2

syms c_ T_;
dotc_ = q/V*(cfbar - c_) - ko * exp(-ER/T_)*c_;
dotT_ = UA/(V*rho*cp)*(Tcbar-T_)+q/V*(Tf-T_)-DH/(rho*cp)*ko*exp(-ER/T_)*c_;
eqns_ = [dotc_ == 0 , dotT_ == 0];
S_ = vpasolve(eqns_,[c_,T_], [0.87, 324]);

ctilde = double(S_.c_);
Ttilde = double(S_.T_);

clear c_ T_ dotc_ dotT_ eqns_ S_;
