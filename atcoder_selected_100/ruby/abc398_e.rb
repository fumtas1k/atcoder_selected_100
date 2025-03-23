# -
# ABC398/E
# 深さ優先探索
# 二部グラフ = 奇閉路がない

require "set"

N = gets.to_i
edges = Array.new(N + 1) { [] }
used = Set.new
(N - 1).times do
  u, v = gets.split.map(&:to_i).sort
  used << [u, v]
  edges[u] << v
  edges[v] << u
end

colors = Array.new(2) { [] }
dfs = ->(pos = 1, pre = -1, color = 0, colors) do
  colors[color] << pos
  edges[pos].each do |to|
    next if to == pre
    dfs.(to, pos, 1 - color, colors)
  end
end

interactive = ->(order, candidates, used) do
  puts order
  $stdout.flush
  if order == "Second"
    i, j = gets.split.map(&:to_i)
    exit if [i, j] == [-1, -1]
    used << [i, j]
  end

  loop do
    candidates.pop while used.include?(candidates.last)
    puts candidates.pop.join(" ")
    $stdout.flush

    i, j = gets.split.map(&:to_i)
    exit if [i, j] == [-1, -1]
    used << [i, j]
  end
end

dfs.(1, -1, 0, colors)

candidates = colors[0].product(colors[1]).map { _1.sort }
order = (colors[0].size * colors[1].size - (N - 1)).odd? ? "First" : "Second"
interactive.(order, candidates, used)
