function out = twos_com(in)
if in(1)
    temp = bi2de(~in(2:end),'left-msb');
    temp = temp+1;
    out = -temp;
else
    out = bi2de(in,'left-msb');
end
end