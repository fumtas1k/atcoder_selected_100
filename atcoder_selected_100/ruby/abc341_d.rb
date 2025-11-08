# -
# ABC431/D
# 動的計画法:ナップサックDP
# 次元を下げる

N = gets.to_i
WHB = Array.new(N) { gets.split.map(&:to_i) }
total_b = 0
total_w = 0
WHB.each do |w, h, b|
  total_b += b
  total_w += w
end

# 全ての部品を体に使った時の嬉しさからスタートし、重量の半分までを目指すので、頭の重量はdpに加味しなくて良い
# フルでdpを回すと最大で500 * 500 * 500 = 1.25 * 10^8 回になるので、重量の半分までに制限する
# どのみちテストケースにによってはrubyの場合は、TLEになる可能性がある
# dp[i] = 体の重量を i だけ引いた時の嬉しさの最大値
dp = Array.new(total_w / 2 + 1, 0)
dp[0] = total_b

WHB.each do |w, h, b|
  (total_w / 2).downto(w) do |i|
    dp[i] = [dp[i], dp[i - w] - b + h].max
  end
end

puts dp.max
