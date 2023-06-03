# 37
# DPL-1/B
# 動的計画法:ナップザックDP

N, M = gets.split.map(&:to_i)
C = gets.split.map(&:to_i).sort.reverse
dp = [Float::INFINITY] * (N + 1)
dp[0] = 0

C.each do |c|
  (N + 1).times do|i|
    dp[i] = [dp[i], dp[i - c] + 1].min if i - c >= 0
  end
end

puts dp[-1]
