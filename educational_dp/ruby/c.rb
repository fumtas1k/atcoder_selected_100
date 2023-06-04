# C

N = gets.to_i
ABC = Array.new(N) { gets.split.map(&:to_i) }

dp = Array.new(N + 1) { [0] * 3 }

N.times do |i|
  3.times do |j|
    dp[i + 1][j] = [dp[i][(j + 1) % 3], dp[i][(j + 2) % 3]].max + ABC[i][j]
  end
end

puts dp[-1].max
