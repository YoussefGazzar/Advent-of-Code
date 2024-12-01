def bs((t, d))
  d += 1
  l = 1
  r = t-1
  
  while l <= r
    m = ((l+r)/2).floor
    rest = t - m
    target = m * rest
    if target == d
      answer = rest - m + 1
			return answer
    elsif target < d
      l = m + 1
    else
      answer = rest - m + 1
      r = m - 1
    end
  end
	answer
end

pp bs([71530, 940200])