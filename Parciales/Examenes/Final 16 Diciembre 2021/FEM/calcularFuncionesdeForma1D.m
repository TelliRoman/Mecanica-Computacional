%puntos
p=[0 0.5];

%inicializo
N1=@(x)0;
N2=@(x)0;
N3=@(x)0;
N4=@(x)0;

%%%%%%%%%%%%%%%%%%%%%%%%%
%COORDENADAS CARTESIANAS
%%%%%%%%%%%%%%%%%%%%%%%%%

if(length(p)==2) %lineal
  N1=@(x)(x-p(2))/(p(1)-p(2));
  N2=@(x)(x-p(1))/(p(2)-p(1));
elseif (length(p)==3) %bilineal
  N1=@(x)((x-p(2))*(x-p(3)))/((p(1)-p(2))*(p(1)-p(3)));
  N2=@(x)((x-p(1))*(x-p(3)))/((p(2)-p(1))*(p(2)-p(3)));
  N3=@(x)((x-p(1))*(x-p(2)))/((p(3)-p(1))*(p(3)-p(2)));
elseif (length(p)==4) %cubica
  N1=@(x)((x-p(2))*(x-p(3))*(x-p(4)))/((p(1)-p(2))*(p(1)-p(3))*(p(1)-p(4)));
  N2=@(x)((x-p(1))*(x-p(3))*(x-p(4)))/((p(2)-p(1))*(p(2)-p(3))*(p(2)-p(4)));
  N3=@(x)((x-p(1))*(x-p(2))*(x-p(4)))/((p(3)-p(1))*(p(3)-p(2))*(p(3)-p(4)));
  N4=@(x)((x-p(1))*(x-p(2))*(x-p(3)))/((p(4)-p(1))*(p(4)-p(2))*(p(4)-p(3)));
end

N1
N2
N3
N4

%graficar
%figure
%hold on
%puntos=[p(1):0.1:p(2)];
%plot(puntos,N1(puntos))
%plot(puntos,N2(puntos))
%plot(puntos,N3(puntos))
%plot(puntos,N4(puntos))
%legend("N1","N2","N3","N4")

%%%%%%%%%%%%%%%%%%%%%%%%%
%COORDENADAS NATURALES
%%%%%%%%%%%%%%%%%%%%%%%%%

%Nota: considerar a x como chi

%if(length(p)==2) %lineal
%  N1=@(x)(1/2)*(1-x);
%  N2=@(x)(1/2)*(1+x);
%else (length(p)==3) %bilineal
%  N1=@(x)(1/2).*x.*(x-1);
%  N2=@(x)(1+x).*(1-x);
%  N3=@(x)(1/2).*x.*(x+1);
%else (length(p)==4) %cubica
%  N1=@(x)-(9/16).*(x+(1/3)).*(x-(1/3)).*(x-1);
%  N2=@(x)(27/16).*(x+1).*(x-(1/3)).*(x-1);
%  N3=@(x)-(27/16).*(x+1).*(x+(1/3)).*(x-1);
%  N4=@(x)(9/16).*(x+1).*(x+(1/3)).*(x-(1/3));
%end

%N1
%N2
%N3
%N4

%graficar
%figure
%hold on
%puntos=[-1:0.1:1];
%plot(puntos,N1(puntos))
%plot(puntos,N2(puntos))
%plot(puntos,N3(puntos))
%plot(puntos,N4(puntos))
%legend("N1","N2","N3","N4")