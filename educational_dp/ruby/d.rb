# D

N, W = gets.split.map(&:to_i)
WV = Array.new(N) { gets.split.map(&:to_i) }
dp = Array.new(N + 1) { [0] * (W + 1) }

WV.each_with_index do |(w, v), i|
  (W + 1).times do |j|
    dp[i + 1][j] = dp[i][j]
    dp[i + 1][j] = [dp[i + 1][j], dp[i][j - w] + v].max if j >= w
  end
end

puts dp[-1].max
