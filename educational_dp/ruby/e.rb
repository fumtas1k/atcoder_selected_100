# E

INF = 1 << 60

N, W = gets.split.map(&:to_i)
WV = Array.new(N) { gets.split.map(&:to_i) }
V_MAX = N * 10 ** 3

# dp[i] = 価値iのときの重さの総和の最小値
dp = [INF] * (V_MAX + 1)
dp[0] = 0

WV.each do |w, v|
  V_MAX.downto(v) do |i|
    dp[i] = [dp[i], dp[i - v] + w].min
  end
end

puts V_MAX.downto(0).find { dp[_1] <= W }
