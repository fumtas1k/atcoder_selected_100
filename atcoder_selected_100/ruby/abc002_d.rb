# 12
# ABC002/D
# 全探索:ビット全探索

N, M = gets.split.map(&:to_i)
dp = Array.new(N) { [false] * N }
M.times do
  x, y = gets.split.map(&:to_i).map(&:pred)
  dp[x][y] = dp[y][x] = true
end

ans = []
(1 << N).times do |bit|
  members = N.times.filter { bit >> _1 & 1 == 1 }
  ans << members.size if members.combination(2).all? { |x, y| dp[x][y] }
end

puts ans.max
