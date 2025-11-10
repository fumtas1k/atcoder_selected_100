# -
# 二分探索
# 決め打ち二分探索, 最小値の最大化

INF = 1 << 60
def bsearch(ok, ng, &block)
  while (ng - ok).abs > 1
    mid = (ok + ng) / 2
    block.(mid) ? ok = mid : ng = mid
  end
  ok
end

N, X = gets.split.map(&:to_i)
# dp[i][x] := カロリーの合計がxのときのビタミンViの摂取量の最大値
dp = Array.new(3) { [-INF] * (X + 1) }
3.times { dp[_1][0] = 0 }

N.times do
  v, a, c = gets.split.map(&:to_i)
  v -= 1
  X.downto(c) do |i|
    dp[v][i] = [dp[v][i], dp[v][i - c] + a].max
  end
end

# 単調増加になるよう補正
3.times do |i|
  X.times do |x|
    dp[i][x + 1] = [dp[i][x + 1], dp[i][x]].max
  end
end

can_min = -> a do
  x = 0
  3.times do |i|
    return false if dp[i][X] < a
    x += bsearch(X, 0) { dp[i][_1] >= a }
  end
  x <= X
end

puts bsearch(0, 10 ** 9 + 1, &can_min)
