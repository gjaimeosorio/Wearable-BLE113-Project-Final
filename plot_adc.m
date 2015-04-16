function plot_adc(file, fs)
fh = fopen(file);
line = fgetl(fh);
data = [];
while(ischar(line))
    ind = strfind(line,'value:');
    if (ind)
        % temp is the 4 hex digits after "value: "
        temp = line(ind+6:end);
        % data is 12 bits, last 8 plus first 4
        for i = ((length(temp)/4:-1:1) - 1) 
            temp2 = temp((i*4+1):(i*4+4));
            num = hex2dec(temp2([3,4,1,2]));
            data = [data,num];
        end

%         temp = line(ind+6:end);
%         data = [data, hex2dec(temp([3,4,1]))];
    end
    line = fgetl(fh);
end
fclose(fh);

L = length(data);
t = (0:L-1)/fs;
NFFT = 2^nextpow2(L);
Y = fft(data,NFFT)/L;
f = fs/2*linspace(0,1,NFFT/2+1);
subplot(2,1,1)
plot(t,data)
subplot(2,1,2)
plot(f,2*abs(Y(1:NFFT/2+1)))
% hold on
% d_max = max(data);
% d_min = min(data);
% for i = 8:8:length(data)
%     plot([i,i],[dmax,dmin],'r-')
% end