function twos = pos2s(In,n)
twos(1) = In(1);
  for c = 2:n
      if In(c) == '1'
          twos(c) = '0';
      else
          twos(c) = '1';
      end
  end
  twos = bin2dec(twos);
  twos = twos + 1;
  twos = dec2bin(twos,n);
end