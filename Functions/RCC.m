%rcc
%vk= señal de la ventana vk
%L=Largo de las ventanas
%d0=Delay rate for bit0
%d1=Delay rate for bit1
%len_msg=Largo del mensaje oculto
%out=señal de salida Rcc

function out = RCC(vk, L, d0, d1, len_msg)
N = floor(length(vk)/L);                    %numero de ventanas
vk_dividido = reshape(vk(1:N*L,1), L, N);   %division de vk en el numero de ventanas
data = char.empty(N, 0);

for k=1:N
	rcc = ifft(log(abs(fft(vk_dividido(:,k)))));  % Aplico la ecuacion 3 del instructivo
	if (rcc(d0+1) >= rcc(d1+1)) % condicion para ver si la ventana tiene un retardo grande o pequeño
        data(k) = '0';
	else
        data(k) = '1';
	end
end

m   = floor(N/8);
bin = reshape(data(1:8*m), 8, m)';   %Retrieved in binary
out = char(bin2dec(bin))';           %bin=>char

if (len_msg~=0) % esto es por si no hay mensaje oculto
	out = out(1:len_msg);
end