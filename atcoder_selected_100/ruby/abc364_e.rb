# -
# 動的計画法:ナップザック問題
# キーと値を入れ替える

N, X, Y = gets.split.map(&:to_i)
AB = Array.new(N) { gets.split.map(&:to_i) }.sort_by(&:first)

# dp[i][j] = 甘さの合計がjとなるるようにi個選んだときのしょっぱさの合計の最小値
# Float::INFINITYで初期化するとTLEになる
dp = Array.new(N + 1) { Array.new(X + 1, Y + 1) }
dp[0][0] = 0

AB.each_with_index do |(a, b), i|
  break if X < a
  i.downto(0) do |j|
    (X - a).downto(0) do |k|
      dp[j + 1][k + a] = [dp[j + 1][k + a], dp[j][k] + b].min
    end
  end
end

N.downto(0) do |i|
  next unless dp[i].any? { _1 <= Y }
  puts [i + 1, N].min
  exit
end
