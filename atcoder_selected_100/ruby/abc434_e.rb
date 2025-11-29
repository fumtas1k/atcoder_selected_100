# -
# ABC434/E
# 深さ優先探索, グラフ

N = gets.to_i
# グラフとして考える
edges = Hash.new { |h, k| h[k] = [] }
N.times do
  x, r = gets.split.map(&:to_i)
  edges[x - r] << x + r
  edges[x + r] << x - r
end

visited = Set.new

dfs = ->(pos, pre) do
  return [false, 0] if visited.include?(pos)
  visited << pos
  is_tree = true
  cnt = 1
  edges[pos].each do |nxt|
    next if nxt == pre
    t, c = dfs.(nxt, pos)
    is_tree &= t
    cnt += c
  end
  [is_tree, cnt]
end

ans = 0
edges.each_key do |start|
  next if visited.include?(start)
  is_tree, cnt = dfs.(start, nil)
  # グラフが木なら塗り分けの最大は cnt - 1, 木でないなら cnt
  ans += is_tree ? cnt - 1 : cnt
end

puts ans

