rho_w = 1e3;                            % [kg*m^-3]

msys = liter2kg(400,rho_w);             % Systemmasse [kg]
mdot_zu_1 = lpm2kgps(30,rho_w);         % [kg*s^-1]
mdot_zu_2 = liter2kg(0.1,rho_w);        % 

mdot_ab_max = lpm2kgps(90,rho_w);
p = 0.80;
mdot_ab_1 = (1 - p) * mdot_ab_max;
mdot_ab_L = lpm2kgps(0.25,rho_w);

% b) änderung der Wassermasse mit der zeit bei n=1
n=1;
mdot_ab_2 = n * mdot_ab_L;
dm_dt = (mdot_zu_1 + mdot_zu_2) - (mdot_ab_1 + mdot_ab_2);
fprintf(1,'b)\tÄnderung der Wassermasse mit der Zeit ist %.3f [kg * s^-1].\n',dm_dt);

% c) wasservolumen v*
syms t;
v_star = symfun(msys + dm_dt * t,[t]);
fplot(kg2liter(v_star,rho_w),[0 10])

% e) massenstrom überlauf
n = 0;
mdot_ab_2 = n * mdot_ab_L;7
mdot_ab_3 = mdot_zu_1 + mdot_zu_2 - (mdot_ab_1 + mdot_ab_2);
fprintf(1,'e)\tDer Überlauf muss für einen Massenstrom von %.3f [kg/s] ausgelegt sein.\n',mdot_ab_3);

function [kgps] = lpm2kgps(lpm,density)
kgps = vol2mass(liter2cbm(lpm),density) ./ 60;
end

function [kg] = liter2kg(liter,density)
kg = vol2mass(liter2cbm(liter),density);
end

function [liter] = kg2liter(kg,density);
liter = cbm2liter(mass2vol(kg,density));
end

function [vol] = liter2cbm(vol)
vol = vol * 1e-3;
end

function [vol] = cbm2liter(vol)
vol = vol * 1e3;
end

function [mass] = vol2mass(vol,density)
mass = vol * density;
end

function [vol] = mass2vol(mass,density)
vol = mass ./ density;
end