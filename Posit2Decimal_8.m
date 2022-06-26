clc
clearvars

In = input("Enter posit in binary {8,2} : ","s");
P = fi(bin2dec(In),0,8,0,'OverflowAction','Wrap');

if getmsb(P)==1
    s = 1;
else
    s = 0;
end

if P == 0
    Out = 0;
    fprintf('%s -> %d\n', In,Out)
    return
elseif P == 128
    fprintf('%s -> +- infinity\n', In)
    return
end

bits = 6;
Rk_1 = bitget(P,7);

k = 1;

for c = 1:6
  check = bitget(P,7-c);
  if check ~= Rk_1 || c == 14
      bits = bits - c;
      break
  end
  k = k + 1;
end

if check == Rk_1
    k = k+1;
end

if Rk_1 == 0
    r = -k;
else
    r = k-1;
end

if bits > 2
    es = 2;
    m = bits - 2;
else
    es = bits;
    m = 0;
end

e = 0;

if es>0
    for c = 1:es
        if bitget(P,7-(k+c)) == 1
            e = e + 2^((es-c));
        end
    end
end

f = 0;

if m >0
    for c = 1:m
        if bitget(P,c) == 1
            f = f + 2^(-(m-c+1));
        end
    end
end

Out = ((1-3*s)+f) * 2^((1-2*s)*(4*r + e +s));

fprintf('%s -> %d\n', In,Out)
