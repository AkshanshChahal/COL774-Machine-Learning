function z = laplace_logx(x, y)

modV = 17711;
z = log((x+1)/(y+modV));    % Can even hardcode the value of modV !

end