function D = tension(E,v,tipo)
    if(tipo == 1) %tension plana
        D = (E/(1-(v*v))).*[1,v,0;v,1,0;0,0,(1-v)/2];
    else
        D = E/((1+v)*(1-2*v)).*[1-v,v,0;v,1-v,0;0,0,(1-2*v)/2];
    end    
end