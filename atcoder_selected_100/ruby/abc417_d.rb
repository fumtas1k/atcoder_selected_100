# -
# ABC417/D
# 動的計画法:その他
# 累積和
# 二分探索法
# 後ろから考える

N = gets.to_i
PAB = Array.new(N) { gets.split.map(&:to_i) }
MAX = PAB.map { |p, a, b| p + a }.max

# dp[i][j] := i 番目のプレゼントを受け取った直後のテンションの値がjのときの、最終的なテンションの値
dp = Array.new(N + 1) { Array.new(MAX + 1, 0) }
# すべて受け取り終わったときのテンションがjなら、最終的なテンションは j
dp[N] = [*0 .. MAX]

(N - 1).downto(0) do |i|
  p, a, b = PAB[i]
  (MAX + 1).times do |j|
    dp[i][j] = j <= p ? dp[i + 1][j + a] : dp[i + 1][[j - b, 0].max]
  end
end

# bの累積和を計算しておく
bcsum = PAB.reduce([0]) {|acc, (p, a, b)| acc << acc[-1] + b }

access = -> x do
  return dp[0][x] if x <= MAX

  # xがMAXより大きい場合は、しばらく下がり続ける
  need_down_index = bcsum.bsearch_index { _1 >= x - MAX }

  # テンションが下がり続けてもMAXより大きい場合は、最終的なテンションは x から　 Bの合計を引いた値
  return x - bcsum[-1] unless need_down_index

  # テンションが下がり続けてMAX以下になったタイミング
  # next_down_index番目のプレゼントを受け取った直後のテンションが [x - bcsum[need_down_index], 0].max になる
  dp[need_down_index][[x - bcsum[need_down_index], 0].max]
end

ans = gets.to_i.times.map do
  access[gets.to_i]
end

puts ans

