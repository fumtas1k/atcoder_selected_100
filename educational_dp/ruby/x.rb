# X

W_MAX = 2 * 10 ** 4
N = gets.to_i
# 総重量をwとし、a < bが最適な時、
# x <= [sa, sb - wa].min かつ
# [sa, sb - wa].min > [sb, sa - wb].min である。　
# 言い方を変えると、i - 1番目までの総重量はsi以下にしなければならず、i + 1番目を考えるとsi + wi は小さい方が良いので
# si + wi の小さい順に並べて処理すれば良い。
WSV = Array.new(N) { gets.split.map(&:to_i) }.sort_by {|w, s, _| w + s }

dp = [- Float::INFINITY] * (W_MAX + 1)
dp[0] = 0

WSV.each_with_index do |(w, s, v), i|
  [W_MAX, s + w].min.downto(w) do |j|
    dp[j] = [dp[j], dp[j - w] + v].max
  end
end

puts dp.max
