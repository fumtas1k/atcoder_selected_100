# B

A, B = gets.split.map(&:to_i)
a = gets.split.map(&:to_i)
b = gets.split.map(&:to_i)

# dp[i][j] 左にi個, 右にj個残っている状態から始めて最善を尽くした時の (現在のプレーヤーが得る価値 - 相手のプレーヤーが得る価値)
dp = Array.new(A + 1) { [0] * (B + 1) }

# どちらも残っていない状態を0として最後から考える
(A + 1).times do |i|
  (B + 1).times do |j|
    if i > 0 && j == 0
      dp[i][j] = a[A - i] - dp[i - 1][j]
    elsif i == 0 && j > 0
      dp[i][j] = b[B - j] - dp[i][j - 1]
    elsif i > 0 && j > 0
      # 現在の値を最大化できる値を取る
      # 1個前とはプレーヤーが入れ替わるのでdpを引く
      dp[i][j] = [a[A - i] - dp[i - 1][j], b[B - j] - dp[i][j - 1]].max
    end
  end
end

puts (dp[-1][-1] + a.sum + b.sum) / 2
