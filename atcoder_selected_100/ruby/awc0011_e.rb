# -
# AWC0011/E
# 動的計画法:ナップサックDP
# DP復元

N, M = gets.split.map(&:to_i)
AB = Array.new(N) { gets.split.map(&:to_i) }
# dp[N][M]で価値が最大値にするために初期化を -INF ではなく 0 にする
dp = Array.new(N + 1) { [0] * (M + 1) }

AB.each_with_index do |(a, b), i|
  (M + 1).times do |j|
    dp[i + 1][j] = dp[i][j]
    dp[i + 1][j] = [dp[i + 1][j], dp[i][j - a] + b].max if j >= a
  end
end

ans = ["No"] * N
# reach = [M] にして、reach.each でループすると1問 TLE になる
reach = [false] * (M + 1)
reach[M] = true

N.downto(1) do |i|
  a, b = AB[i - 1]
  next_reach = [false] * (M + 1)
  (M + 1).times do |j|
    next unless reach[j]
    # 取らない遷移
    if dp[i][j] == dp[i - 1][j]
      next_reach[j] = true
    end
    # 取る遷移
    if j >= a && dp[i][j] == dp[i - 1][j - a] + b
      ans[i - 1] = "Yes"
      next_reach[j - a] = true
    end
  end
  reach = next_reach
end

puts ans
