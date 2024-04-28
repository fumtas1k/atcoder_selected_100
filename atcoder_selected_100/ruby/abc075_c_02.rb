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
used = [false] * N
idx = -1
cnt = 0

dfs =-> (pos, pre = -1) do
  used[pos] = true
  ord[pos] = low[pos] = (idx += 1)
  G[pos].each do |to|
    next if to == pre
    if used[to]
      low[pos] = [low[pos], ord[to]].min
    else
      dfs.call(to, pos)
      low[pos] = [low[pos], low[to]].min
      cnt += 1 if ord[pos] < low[to]
    end
  end
end

dfs.call(0)
puts cnt
