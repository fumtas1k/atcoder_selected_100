# -
# ABC428/E
# 幅優先探索
# 木の直径
# 両端は全ての頂点の最遠距離

N = gets.to_i
edges = Array.new(N + 1) { [] }
(N - 1).times do
  a, b = gets.split.map(&:to_i)
  edges[a] << b
  edges[b] << a
end

# 木の直径の両端はどの頂点からも距離が最大となる頂点
# 木の直径の両端のうち、距離が最大でかつ番号が最大となる頂点が答えとなる

calc = -> start do
  dists = Array.new(N + 1)
  dists[0] = dists[start] = 0
  deque = [start]
  until deque.empty?
    pos = deque.shift
    edges[pos].each do |nex|
      next if dists[nex]
      dists[nex] = dists[pos] + 1
      deque << nex
    end
  end
  dists
end

dists1 = calc.(1)
u = N
N.downto(1) do |i|
  next if dists1[u] >= dists1[i]
  u = i
end

dists_u = calc.(u)
v = N
N.downto(1) do |i|
  next if dists_u[v] >= dists_u[i]
  v = i
end

dists_v = calc.(v)

ans = 1.upto(N).map do |i|
  if dists_u[i] == dists_v[i]
    [u, v].max
  elsif dists_u[i] > dists_v[i]
    u
  else
    v
  end
end

puts ans
