# -
# ABC348/E
# 深さ優先探索
# 木の重心

N = gets.to_i
G = Array.new(N) { [] }
(N - 1).times do
  a, b = gets.split.map(&:to_i).map(&:pred)
  G[a] << b
  G[b] << a
end
C = gets.split.map(&:to_i)

@total = C.sum
@center = -1
def dfs1(pos = 0, pre = -1)
  res = C[pos]
  max = 0
  G[pos].each do |i|
    next if i == pre
    now = dfs1(i, pos)
    max = [max, now].max
    res += now
  end
  # posを中心とした時の各部分木の重みの合計の最大を求める
  max = [max, @total - res].max
  # 部分木の重みの合計の最大値がそれ以外より大きければそちらに中心を移動した方が Ci * d(x, i)の合計が最小化する。
  # つまりそちらの方が木の重心になる
  # max <= @total - max であるなら重心。最大で２カ所存在するがどちらでも問題ない
  @center = pos if max * 2 <= @total
  res
end

@ans = 0
def dfs2(pos = @center, pre = -1, dist = 0)
  @ans += dist * C[pos]
  G[pos].each do |i|
    next if i == pre
    dfs2(i, pos, dist + 1)
  end
end

dfs1
dfs2
puts @ans
