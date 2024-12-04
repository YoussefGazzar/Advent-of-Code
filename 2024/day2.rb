require_relative '../fetch_input'

input = InputFetcher.fetch(2024, 2)
# part 1 
ans = 0 
input.each do |report|
  sign = 0
  report = report.split.map(&:to_i)
  report.each_cons(2) do |a, b|
    sign = a <=> b
    break if sign != 0
  end
  nums = [1*sign, 3*sign].sort
  ans += 1 if report.each_cons(2).all? do |(a, b)| 
    (a-b).between?(nums[0], nums[1]) 
  end
end
p ans

# part 2
ans = 0 
input.each do |report|
  org_report = report.split.map(&:to_i)

  (0..report.size).each do |i|
    report = org_report.dup
    report.delete_at(i)
    sign = 0

    report.each_cons(2) do |a, b|
      sign = a <=> b
      break if sign != 0
    end

    nums = [1*sign, 3*sign].sort
    safe = report.each_cons(2).all? do |(a, b)| 
      (a-b).between?(nums[0], nums[1]) 
    end
    
    if safe
      ans += 1
      break
    end
  end
end
p ans