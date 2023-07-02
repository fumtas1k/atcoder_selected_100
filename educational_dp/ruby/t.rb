# T

M = 10 ** 9 + 7
N = gets.to_i
S = gets.chomp.chars

# dp[i][j] (i + 1)番目までの位置関係を決めた時の(i + 1)番目に決めた値のindexはj
dp = Array.new(N) { [0] * N }
dp[0][0] = 1

(N - 1).times do |i|
  # 事前に(i + 1)番目のdpの累積和と求めておく
  csum = dp[i].reduce([0]) {|acc, j| acc << acc[-1] + j }
  case S[i]
  when "<"
    (i + 1).times do |j|
      # (i + 2)番目のindexが(j + 1)である時、(i + 1)番目の取りうるindexはj以下
      dp[i + 1][j + 1] = csum[j + 1] % M
    end
  when ">"
    (i + 1).times do |j|
      # (i + 2)番目のindexがjである時、(i + 1)番目の取りうるindexはj以上
      dp[i + 1][j] = (csum[i + 1] - csum[j]) % M
    end
  end
end

puts dp[-1].sum % M
