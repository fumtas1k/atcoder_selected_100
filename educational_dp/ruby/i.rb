# I

N = gets.to_i
P = gets.split.map(&:to_f)

# dp[投げたコインの数][表が出たコインの数] = 確率
dp = Array.new(N + 1) { Array.new((N + 1), 0) }
dp[0][0] = 1

P.each_with_index do |q, i|
  (N + 1).times do |j|
    dp[i + 1][j] += dp[i][j] * (1 - q)
    dp[i + 1][j + 1] += dp[i][j] * q if j < N
  end
end

puts dp[-1][(N + 1) / 2 ..].sum
