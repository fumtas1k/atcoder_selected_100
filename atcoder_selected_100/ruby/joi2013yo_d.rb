# 41
# JOI2013YO/D
# 動的計画法:ナップサックDP

D, N = gets.split.map(&:to_i)
T = Array.new(D) { gets.to_i }
ABC = Array.new(N) { gets.split.map(&:to_i) }
C = Array.new(60 + 1) { [] }
ABC.each do |a, b, c|
  a.upto(b) do |i|
    C[i] << c
  end
end

# dp[i番目のT][最後の派手さがj] = 派手さの差の合計の最大値
dp = Array.new(D) { Array.new(100 + 1, -1) }
C[T[0]].each do |c|
  dp[0][c] = 0
end

1.upto(D - 1) do |i|
  t = T[i]
  C[t].each do |c|
    (100 + 1).times do |j|
      next if dp[i - 1][j] == -1
      dp[i][c] = [dp[i][c], dp[i - 1][j] + (c - j).abs].max
    end
  end
end

puts dp[-1].max
