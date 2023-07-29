# F

M = 10 ** 9 + 7
N, K = gets.split.map(&:to_i)

# dp[駅][0 = 停車しない, 1 = 停車する] = 場合の数
dp = Array.new(N + 1) { [0] * 2 }
dp[0][0] = dp[1][1] = 1

2.upto(N) do |i|
  dp[i][0] = dp[i][1] = dp[i - 1].sum % M
  # (i - K)駅で停車せず、その後全て停車する場合を引く
  dp[i][1] = (dp[i][1] - dp[i - K][0] + M) % M if i >= K
end

puts dp[-1][1]
