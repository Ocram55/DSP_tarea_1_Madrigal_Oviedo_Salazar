#<include>Kernel.m</include>

#t = 0:0.1:1;
#prueba = sin(2*pi*t);
prueba = ones(1,10);
bitStream = 1;

convOut = Kernel(prueba, bitStream);

plot(convOut);