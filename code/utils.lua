function mysgn(v)
  return v == 0 and 0 or sgn(v)
end

function randint(x, y)
  return flr(rnd(y - x + 1)) + x
end

function randfloat(x, y)
  return x + rnd(y - x)
end