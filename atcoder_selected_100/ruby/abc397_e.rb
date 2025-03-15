# -
# ABC397/E
# 木DP

N, K = gets.split.map(&:to_i)
TOTAL = N * K
edges = Array.new(TOTAL) { [] }

(TOTAL - 1).times do
  u, v = gets.split.map(&:to_i).map(&:pred)
  edges[u] << v
  edges[v] << u
end

size = Array.new(TOTAL, 1)
dfs = ->(pos, pre) do
  children = 0
  edges[pos].each do |to|
    next if to == pre
    return false unless dfs.(to, pos)
    if size[to] > 0
      size[pos] += size[to]
      children += 1
    end
  end

  # 頂点数がK未満でも子が2つ以上ある場合はパスになり得ない
  return false if size[pos] < K && children >= 2
  # 頂点数がKを超える場合　もしくは 子が3つ以上ある場合はパスになり得ない
  return false if size[pos] > K || children >= 3
  # 頂点数がKになった場合は頂点数を取り除く
  size[pos] = 0 if size[pos] == K
  true
end

puts dfs.(0, -1) ? "Yes" : "No"
