# 51
# JOI2014YO/D
# 動的計画法:bitDP

M = 10_007
N = gets.to_i
S = gets.chomp.chars.map(&:to_sym)
JOI = {J: 1, O: 2, I: 4}
dp = Array.new(N) { [0] * (1 << 3) }

S.each_with_index do |c, i|
  (1 << 3).times do |j|
    if i == 0
      dp[i][j] = 1 if j & JOI[:J] > 0 && j & JOI[c] > 0
    else
      next if j & JOI[c] == 0
      (1 << 3).times do |k|
        next if j & k == 0
        dp[i][j] += dp[i - 1][k]
        dp[i][j] %= M
      end
    end
  end
end

puts dp[-1].sum % M
