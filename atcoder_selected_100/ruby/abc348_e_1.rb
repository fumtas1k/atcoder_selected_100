# -
# ABC348/E
# 深さ優先探索
# 木の重心

# sum(Ci * d(x, i))が最小となるxは重心である
N = gets.to_i
G = Array.new(N) { [] }
(N - 1).times do
  a, b = gets.split.map(&:to_i).map(&:pred)
  G[a] << b
  G[b] << a
end
C = gets.split.map(&:to_i)
total = C.sum
centroid = []

# 重心を求める
dfs1 = ->(pos, pre = -1) do
  csum = C[pos]
  max = 0
  G[pos].each do |nex|
    next if nex == pre
    c = dfs1.(nex, pos)
    max = [max, c].max
    csum += c
  end
  # posを中心とした時の各部分木の重みの合計の最大を求める
  max = [max, total - csum].max
  # 部分木の重みの合計の最大値がそれ以外より大きければそちらに中心を移動した方が Ci * d(x, i)の合計が最小化する。
  # つまりそちらの方が木の重心になる
  # max <= total / 2 であるなら重心。最大で2カ所存在するがどちらでも問題ない
  centroid << pos if max * 2 <= total
  csum
end

ans = 0
# sum(Ci * d(pos, i))を求める
dfs2 = ->(pos, pre = -1, dist = 0) do
  ans += dist * C[pos]
  G[pos].each do |nex|
    next if nex == pre
    dfs2.(nex, pos, dist + 1)
  end
end

dfs1.(0)
dfs2.(centroid[0])
puts ans
