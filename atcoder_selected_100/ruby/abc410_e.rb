# -
# ABC410/E
# 動的計画法:ナップサックDP
# キーと値を入れ替える

N, H, M = gets.split.map(&:to_i)
dp = Array.new(N + 1) { Array.new(M + 1, -1) }
dp[0][M] = H

ans = N
N.times do |i|
  a, b = gets.split.map(&:to_i)
  ok = false
  M.downto(0) do |m|
    dp[i + 1][m] = [dp[i + 1][m], dp[i][m] - a].max
    dp[i + 1][m - b] = [dp[i + 1][m - b], dp[i][m]].max if m - b >= 0
    ok ||= dp[i + 1][m] >= 0
  end
  next if ok
  break ans = i
end

puts ans

