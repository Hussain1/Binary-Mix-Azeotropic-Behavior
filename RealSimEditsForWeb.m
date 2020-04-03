function RealSimEditsForWeb(P,B1,C1,D1,B2,C2,D2,x1Az,TAz)
format short
x2Az = 1-x1Az;
activity_Coeff1_Az = P/(10^(B1-C1/(TAz+D1)));
activity_Coeff2_Az = P/(10^(B2-C2/(TAz+D2)));
A1 = (1+(x2Az*log(activity_Coeff2_Az))/(x1Az*log(activity_Coeff1_Az)))^2*log(activity_Coeff1_Az);
A2 = (1+(x1Az*log(activity_Coeff1_Az))/(x2Az*log(activity_Coeff2_Az)))^2*log(activity_Coeff2_Az);
y1_set = 0;
T_set = 0;
T1 = 0;
for x1 = 0:0.01:1
    x2 = 1-x1;
    for T = 0:0.0001:600
        activity_Coeff1 = exp((A1*A2^2*x2^2)/((A1*x1+A2*x2)^2));
        activity_Coeff2 = exp((A2*A1^2*(x1)^2)/((A1*x1+A2*x2)^2));
        P1 = 10^(B1-C1/(T+D1));
        P2 = 10^(B2-C2/(T+D2));
        if abs(P-x1*P1*activity_Coeff1-x2*P2*activity_Coeff2)<0.01
            T1 = T;
            break
        end
    end
    if T_set == 0;
        T_set = [T1];
    else
        T_set = [T_set,T1];
    end
    P1 = 10^(B1-C1/(T+D1));
    activity_Coeff1 = exp((A1*A2^2*x2^2)/((A1*x1+A2*x2)^2));
    y1 = (x1*P1*activity_Coeff1)/P;
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
plot(x1_set,T_set,y1_set,T_set);
title('Boiling Temprature vs Compound 1 Composition in Vapor and Liquid Phases - Real Simulation')
xlabel('Compound 1 Mole fractions')
ylabel('Temprature(C)')
legend('x','y')
%xlswrite('x1_set_real',transpose(x1_set)) %excel spreadsheets if needed
%xlswrite('y1_set_real',transpose(y1_set)) %excel spreadsheets if needed
%xlswrite('T_set_real',transpose(T_set))  %excel spreadsheets if needed
end