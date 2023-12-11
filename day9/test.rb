def recursion(arr)
  return arr.last if arr.all?(0)
  diff = []
  arr.each_cons(2) do |(a, b)|
    diff << b - a
  end
  depth = arr.last + recursion(diff)
  pp diff
  pp depth
end

lists = [[0, 3, 6, 9, 12, 15], [1, 3, 6, 10, 15, 21], [10, 13, 16, 21, 30, 45]]
lists.each {recursion(_1)}