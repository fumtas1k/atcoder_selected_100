# -
# ABC442/F
# 数学的問題
# 累積和, 動的計画法, バイト列

INF = 1 << 60
HASH = "#".ord

# ある整数列(A1,A2,..,AN) が存在して、以下の条件をともに満たす（ただし、0≦Ai≦Nとする）。
# i行目の左からAiマスが白く塗られており、その他のマスは黒く塗られている。
# A1 ≧ A2 ≧ ... ≧ AN である。

N = gets.to_i
S = Array.new(N) { gets.chomp }

dp = [0] * (N + 1)
N.times do |i|
  min_dp = [INF] * (N + 2)
  N.downto(0) do |j|
    min_dp[j] = [min_dp[j + 1], dp[j]].min
  end
  # 左から見たときの黒の数、右から見たときの白の数
  black_l = 0
  white_r = S[i].count(".")
  dp.clear
  (N + 1).times do |j|
    dp << black_l + white_r + min_dp[j]
    break if j == N
    # S[i][j].ordは遅い
    S[i].getbyte(j) == HASH ? black_l += 1 : white_r -= 1
  end
end

puts dp.min
