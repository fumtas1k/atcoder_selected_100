# -
# 動的計画法:ナップサックDP
# 個数制限付きナップサックDP

N, W = gets.split.map(&:to_i)
VW = []

N.times do
  v, w, m = gets.split.map(&:to_i)
  # m = 2^0 + 2^1 + ... + 2^k + α と分解
  i = 1
  while m > 0
    VW << [v * i, w * i]
    m -= i
    i = [m, i * 2].min
  end
end

dp = Array.new(W + 1, 0)

VW.each do |v, w|
  W.downto(w) do |i|
    dp[i] = [dp[i], dp[i - w] + v].max
  end
end

puts dp.max
