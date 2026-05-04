# -
# ABC
# 数学的な問題
# ダブリング
# LCA(最小共通祖先)

BIT = 20

N = gets.to_i
edges = Array.new(N) { [] }
(N - 1).times do
  x, y = gets.split.map(&:to_i).map(&:pred)
  edges[x] << y
  edges[y] << x
end

parents = Array.new(BIT) { [0] * N }
depth = Array.new(N)
depth[0] = 0

log = [[0, 0]]
until log.empty?
  pos, pre = log.pop
  parents[0][pos] = pre
  edges[pos].each do |to|
    next if to == pre
    depth[to] = depth[pos] + 1
    log << [to, pos]
  end
end

(BIT - 1).times do |i|
  N.times do |j|
    parents[i + 1][j] = parents[i][parents[i][j]]
  end
end

lca = -> (u, v) do
  u, v = v, u if depth[u] < depth[v]
  diff = depth[u] - depth[v]
  (BIT - 1).downto(0) do |i|
    next if diff[i].zero?
    u = parents[i][u]
  end

  return u if u == v

  (BIT - 1).downto(0) do |i|
    next if parents[i][u] == parents[i][v]
    u = parents[i][u]
    v = parents[i][v]
  end
  parents[0][u]
end

gets.to_i.times do
  a, b = gets.split.map(&:to_i).map(&:pred)
  puts depth[a] + depth[b] - 2 * depth[lca.(a, b)] + 1
end
