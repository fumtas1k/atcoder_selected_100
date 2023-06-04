# 38
# ALDS1-10/C
# 動的計画法:ナップザックDP
# 最長共通部分列(LCS)

def lcs(x, y)
  dp = Array.new(x.size + 1) { [0] * (y.size + 1) }
  (1 .. x.size).each do |i|
    (1 .. y.size).each do |j|
      dp[i][j] = [dp[i - 1][j], dp[i][j - 1]].max
      dp[i][j] = [dp[i][j], dp[i - 1][j - 1] + 1].max if x[i - 1] == y[j - 1]
    end
  end
  dp[-1].max
end

gets.to_i.times do
  puts lcs(gets.chomp.chars, gets.chomp.chars)
end
