# -
# ABC402/C
# その他

N, M = gets.split.map(&:to_i)
ingredient_to_menus = Array.new(N) { [] }
menus = Array.new(M, 0)
M.times do |i|
  k, *arr = gets.split.map(&:to_i)
  menus[i] = k
  arr.each do |j|
    ingredient_to_menus[j - 1] << i
  end
end
B = gets.split.map(&:to_i).map(&:pred)

ans = [0]
B.each_with_index do |b, i|
  ans[i] ||= ans[i - 1]
  ingredient_to_menus[b].each do |menu|
    menus[menu] -= 1
    ans[i] += 1 if menus[menu].zero?
  end
end

puts ans
