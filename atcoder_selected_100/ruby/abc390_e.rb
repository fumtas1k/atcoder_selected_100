# -
# 二分探索
# 決め打ち二分探索, 最小値の最大化

INF = 1 << 60

N, X = gets.split.map(&:to_i)
dp = Array.new(3) { Array.new(X + 1, -INF) }
3.times { dp[_1][0] = 0 }

N.times do
  v, a, c = gets.split.map(&:to_i)
  v -= 1
  X.downto(c) do |j|
    dp[v][j] = [dp[v][j], dp[v][j - c] + a].max
  end
end

# 単調増加にする
3.times do |v|
  X.times do |j|
    dp[v][j + 1] = [dp[v][j], dp[v][j + 1]].max
  end
end

judge = ->(a) do
  x = 0
  3.times do |v|
    return false if dp[v][X] < a
    x += (0 .. X).bsearch { dp[v][_1] >= a }
  end
  x <= X
end

ok = 0
ng = 10 ** 9 + 1
while ng - ok > 1
  mid = (ok + ng) / 2
  judge.(mid) ? ok = mid : ng = mid
end

puts ok
