# -
# 数学的な問題
# 有効グラフ

N, M = gets.split.map(&:to_i)
edges = Array.new(N) { [] }
M.times do
  u, v = gets.split.map(&:to_i).map(&:pred)
  edges[u] << v
end

visited = Hash.new(false)
can = Hash.new(false)
can[0] = true
N.times do |i|
  if can[i]
    stack = [i]
    visited[i] = true
    until stack.empty?
      k = stack.pop
      edges[k].each do |to|
        if !visited[to] && to <= i
          visited[to] = true
          stack << to
        end
        can[to] = true
      end
    end
  end

  puts visited.size == i + 1 ? can.size - visited.size : -1
end

