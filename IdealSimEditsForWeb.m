function IdealSimEditsForWeb(P,B1,C1,D1,B2,C2,D2)
format short
y1_set = 0;
T_set = 0;
T1 = 0;
for x1 = 0:0.01:1
    x2 = 1-x1;
    for T = 0:0.0001:600
        P1 = 10^(B1-C1/(T+D1));
        P2 = 10^(B2-C2/(T+D2));
        if abs(P-x1*P1-x2*P2)<0.01
            T1 = T;
            break
        end
    end
    if T_set == 0;
        T_set = [T1];
    else
        T_set = [T_set,T1];
    end
    P1 = 10^(B1-C1/(T1+D1));
    y1 = (x1*P1)/P;
    if y1_set == 0
        y1_set = [0,y1];
    else
        y1_set = [y1_set,y1];
    end
end
T_set;
x1_set = [0:0.01:1];
x2_set = 1-x1_set;
y1_set;
y2_set = 1-[y1_set];
plot(x1_set,T_set,y1_set,T_set)
title('Boiling Temprature vs Compound 1 Composition in Vapor and Liquid Phases - Real Simulation')
xlabel('Compound 1 Mole fractions')
ylabel('Temprature(C)')
legend('x','y')
% xlswrite('x1_set_ideal',transpose(x1_set)) %excel spreadsheets if needed
% xlswrite('y1_set_ideal',transpose(y1_set)) %excel spreadsheets if needed
% xlswrite('T_set_ideal',transpose(T_set))   %excel spreadsheets if needed
end