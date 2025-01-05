# -
# 動的計画法:桁DP

def f(x)
  xdigits = x.digits.reverse
  n = xdigits.size
  xtop = xdigits[0]
  # dp[i桁目][最初の数字(0の場合はまだ数字が確定していない)][未満フラグ] = 場合の数
  dp = Array.new(n) { Array.new(10) { Array.new(2, 0) } }
  dp[0][xtop][0] = 1
  xtop.times do |i|
    dp[0][i][1] = 1
  end

  1.upto(n - 1) do |i|
    dp[i][0][1] += dp[i - 1][0][1]
    1.upto(9) do |j|
      # 先頭の数字がここで確定した場合
      dp[i][j][1] += dp[i - 1][0][1]
      j.times do |k|
        dp[i][j][0] += dp[i - 1][j][0] if j == xtop && k < j && k == xdigits[i]
        dp[i][j][1] += dp[i - 1][j][0] if j == xtop && k < j && k < xdigits[i]
        dp[i][j][1] += dp[i - 1][j][1]
      end
    end
  end
  # 0の場合を除く
  dp[-1].flatten.sum - 1
end

L, R = gets.split.map(&:to_i)
puts f(R) - f(L - 1)
