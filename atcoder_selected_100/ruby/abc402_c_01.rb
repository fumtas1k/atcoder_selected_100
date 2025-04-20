# -
# ABC402/C
# その他
# セット
# 後ろから考える

require "set"

N, M = gets.split.map(&:to_i)
G = Array.new(N) { [] }
M.times do |i|
  _, *arr = gets.split.map(&:to_i)
  arr.each do |j|
    G[j - 1] << i
  end
end
B = gets.split.map(&:to_i).map(&:pred).reverse

can_eat = Set.new([*0 ... M])
ans = []
B.each_with_index do |b, i|
  ans << can_eat.size
  G[b].each do |j|
    can_eat.delete(j)
  end
end

puts ans.reverse
