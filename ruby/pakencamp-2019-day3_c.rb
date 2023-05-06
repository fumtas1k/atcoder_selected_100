# 4
# PAKENCAMP-2019-DAY3/C
# 全探索:全列挙

N, M = gets.split.map(&:to_i)
A = Array.new(N) { gets.split.map(&:to_i) }

ans = []
M.times do |i|
  (i + 1).upto(M - 1) do |j|
    ans << A.sum { [_1[i], _1[j]].max }
  end
end

puts ans.max
