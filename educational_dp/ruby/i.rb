# I

N = gets.to_i
P = gets.split.map(&:to_f)

# dp[i] = 表が出たコインの個数がiである確率
dp = [0] * (N + 1)
dp[0] = 1

P.each do |p|
  N.downto(0) do |i|
    dp[i] = dp[i] * (1 - p)
    dp[i] += dp[i - 1] * p if i >= 1
  end
end

puts dp[(N + 1) / 2 ..].sum
