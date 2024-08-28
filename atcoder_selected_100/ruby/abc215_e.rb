# -
# ABC215/E
# ビットDP

M = 998244353

N = gets.to_i
S = gets.chomp.chars.map { _1.ord - 'A'.ord }

# dp[i][bit][v] = i回目、bit種類、v　+ 1種類目の場合の数
dp = Array.new(N + 1) { Array.new(1 << 10) { Array.new(11, 0) } }
dp[0][0][10] = 1

N.times do |i|
  (1 << 10).times do |bit|
    11.times do |v|
      next if dp[i][bit][v].zero?

      # i + 1回目を参加しない場合
      dp[i + 1][bit][v] += dp[i][bit][v]
      dp[i + 1][bit][v] %= M

      # 前回参加と異なる種類のコンテストに参加する場合は、一度もその種類のコンテストに参加していない場合のみ
      next if S[i] != v && bit[S[i]] == 1

      # i + 1回目を参加する場合
      dp[i + 1][bit | (1 << S[i])][S[i]] += dp[i][bit][v]
      dp[i + 1][bit | (1 << S[i])][S[i]] %= M
    end
  end
end

puts dp[N].map { _1.sum % M }.sum % M - 1
