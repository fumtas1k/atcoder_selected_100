# 86
# ABC075/C
# DFS
# 二重辺連結成分分解
# Low Link

N, M = gets.split.map(&:to_i)
G = Array.new(N) { [] }
M.times do
  a, b = gets.split.map(&:to_i).map(&:pred)
  G[a] << b
  G[b] << a
end

ord = []
low = []
idx = cnt = 0

dfs =-> (pos, pre = -1) do
  ord[pos] = low[pos] = idx
  idx += 1
  G[pos].each do |to|
    next if to == pre
    if ord[to]
      low[pos] = [low[pos], ord[to]].min
    else
      dfs.call(to, pos)
      low[pos] = [low[pos], low[to]].min
    end
    cnt += 1 if ord[pos] < low[to]
  end
end

dfs.call(0)
puts cnt
