# D

require "prime"

N, D = gets.split.map(&:to_i)

prime_factor = D.prime_division.to_h
[2, 3, 5].each { prime_factor[_1] ||= 0 }

# 2, 3, 5以外の素数を含む場合は出た目の積がDの倍数にはならないので確率0
if prime_factor.size > 3
  puts 0
  exit
end

X, Y, Z = prime_factor.sort.map { _1[1] }

# dp[i][x][y][z] i回降って2がx回、3がy回、5がz回でる確率
# ただし、それぞれの最大回数(例:2のX回 dp[i][X][y][z])のみX回を超えて出る確率を含む
dp = Array.new(N + 1) { Array.new(X + 1) { Array.new(Y + 1) { Array.new(Z + 1, 0) } } }
dp[0][0][0][0] = 1

N.times do |i|
  (X + 1).times do |x|
    (Y + 1).times do |y|
      (Z + 1).times do |z|
        dp[i + 1][x][y][z] += dp[i][x][y][z] # 目が1
        dp[i + 1][[x + 1, X].min][y][z] += dp[i][x][y][z] # 目が2
        dp[i + 1][x][[y + 1, Y].min][z] += dp[i][x][y][z] # 目が3
        dp[i + 1][[x + 2, X].min][y][z] += dp[i][x][y][z] # 目が4
        dp[i + 1][x][y][[z + 1, Z].min] += dp[i][x][y][z] # 目が5
        dp[i + 1][[x + 1, X].min][[y + 1, Y].min][z] += dp[i][x][y][z] # 目が6
      end
    end
  end
end

puts format( "%#.9f", dp[-1][-1][-1][-1].to_f / (6 ** N))
