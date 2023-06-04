# I

N = gets.to_i
P = gets.split.map(&:to_f)

# dp[投げたコインの数][表が出たコインの数]
dp = Array.new(N + 1) { [0] * (N + 1) }
dp[0][0] = 1

N.times do |i|
  0.upto(i) do |j|
    dp[i + 1][j + 1] += dp[i][j] * P[i]
    dp[i + 1][j] += dp[i][j] * (1 - P[i])
  end
end

puts dp[-1][N / 2 + 1 ..].sum
