function [x,y,z,result]=plotAcc(file)
fh = fopen(file);
line = fgetl(fh);
x =[];
y = [];
z = [];
while(ischar(line))
    ind = strfind(line,'value:');
    if (ind)
        % temp is the 4 hex digits after "value: "
        temp = line(ind+6:end);
        % data is 12 bits, last 8 plus first 4
        x_temp = hexToBinaryVector(temp([1,2]),8);
        x = [x, twos_com(x_temp)];
        y_temp = hexToBinaryVector(temp([3,4]),8);
        y = [y, twos_com(y_temp)];        
        z_temp = hexToBinaryVector(temp([5,6]),8);
        z = [z, twos_com(z_temp)];        
    end
    line = fgetl(fh);
end
fclose(fh);

plot(x,'b-')
hold on
plot(y,'r-')
plot(z,'g-')
legend('x','y','z')

% result = [mean(abs(x)), mean(abs(y)), mean(abs(z))];
result = sum(x.^2+ y.^2+ z.^2);
end
 
