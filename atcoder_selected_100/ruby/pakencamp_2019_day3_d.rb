# 43
# 動的計画法:ナップサックDP

COLORS = "RBW#".bytes
C = COLORS.size - 1
N = gets.to_i
S = Array.new(5) { gets.chomp.bytes }.transpose

dp = Array.new(N + 1) { Array.new(C, Float::INFINITY) }
dp[0].fill(0)

N.times do |i|
  cnts = S[i].tally
  cnts.default = 0
  C.times do |c|
    C.times do |pre_c|
      next if c == pre_c
      dp[i + 1][c] = [dp[i + 1][c], dp[i][pre_c] + (5 - cnts[COLORS[c]])].min
    end
  end
end

puts dp[N].min
