clear
%Constantes ja definidas
k12 = 0.3 * 3600;
k21 = 0.2455 * 3600;
k10 = 0.0643 * 3600;
v1 = 3110;
v2 = 3110;
delta = 1000;
h = 1;

%Valores das varias posiçoes da matriz da equaçao (1)
mat_A = -1 * (k12 + k10)/v1;
mat_B = k21/v1;
mat_C = k12/v2;
mat_D = -1 * k21/v2;
A = [mat_A, mat_B; mat_C, mat_D];
%valores selecionados
xmax = 60;
d_val = 3;

%definiçao dos vetores t, d, c1 e c2
t = 0:1:xmax-1;
d = 1:1:xmax/6;
d(1:xmax/6) = d_val;
d=upsample(d,6);
c1(1:xmax-1) = zeros;
c2(1:xmax-1) = zeros;

for k = 1:xmax-1
    c1(h*(k+1)) = c1(h*k) + h * A(1,:) * [c1(h*k); c2(h*k)] + delta * d(h*k)/v1;
    c2(h*(k+1)) = c2(h*k) + h * A(2,:) * [c1(h*k); c2(h*k)];
end

%Plot dos graficos, sobrepostos
figure(1)
plot(t,c1,'-r')
hold on
plot(t,c2,'-b')
hold on
plot(t,d,'-g')
title("Evolução no tempo da dose e das concentrações de efeito");
xlabel("tempo t (dias)");
ylabel("c1 (mg/kg) a vermelho, c2 (mg/kg) a azul, d (mg) a verde");
