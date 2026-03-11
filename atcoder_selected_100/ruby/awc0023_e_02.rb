# -
# AWC0023/E
# 動的計画法:ビットDP
# ビンパッキング問題

N, C = gets.split.map(&:to_i)
W = gets.split.map(&:to_i)

# 各部分集合について、その荷物の合計重量を事前計算
subset_weight = Array.new(1 << N, 0)
(1 << N).times do |mask|
  total = 0
  W.each_with_index do |w, i|
    total += w if mask[i] == 1
  end
  subset_weight[mask] = total
end

# dp[mask] = mask で表される荷物を全て運ぶのに必要な最小運搬回数
dp = Array.new(1 << N, N + 1)
dp[0] = 0

full_mask = (1 << N) - 1

(1 << N).times do |mask|
  next if dp[mask] == N + 1

  remaining = full_mask ^ mask

  # 残りの荷物の部分集合を列挙 (ビット演算のテクニック)
  sub = remaining
  while sub > 0
    if subset_weight[sub] <= C
      new_mask = mask | sub
      dp[new_mask] = [dp[new_mask], dp[mask] + 1].min
    end
    sub = (sub - 1) & remaining
  end
end

puts dp[-1]

