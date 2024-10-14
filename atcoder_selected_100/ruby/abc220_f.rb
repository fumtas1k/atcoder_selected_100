# -
# 深さ優先探索
# 幅優先探索
# オイラーツアー
# 始点を移動する

N = gets.to_i
edges = Array.new(N) { [] }
(N - 1).times do
  u, v = gets.split.map(&:to_i).map(&:pred)
  edges[u] << v
  edges[v] << u
end

cnts = Array.new(N, 1)
dfs = ->(pos = 0, pre = -1, dis = 0) do
  dis_sum = dis
  edges[pos].each do |to|
    next if to == pre
    dis_sum += dfs.(to, pos, dis + 1)
    cnts[pos] += cnts[to]
  end
  dis_sum
end

ans = Array.new(N, 0)
ans[0] = dfs.(0, -1, 0)

log = [0]
until log.empty?
  pos = log.shift
  edges[pos].each do |to|
    next unless ans[to].zero?
    # 始点をposからtoに変更すると、toの部分木の距離はそれぞれ1減り、残りの部分木の距離はそれぞれ1増える
    ans[to] = ans[pos] + (N - cnts[to]) - cnts[to]
    log << to
  end
end

puts ans
