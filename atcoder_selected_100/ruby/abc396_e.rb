# -
# ABC396/E
# 数学的問題
# ビット
# XOR
# ビット毎に独立で考える

N, M = gets.split.map(&:to_i)
G = Array.new(N) { [] }

M.times do
  x, y, z = gets.split.map(&:to_i)
  x -= 1
  y -= 1
  G[x] << [y, z]
  G[y] << [x, z]
end

visited = Array.new(N, false)
vals = Array.new(N, -1)

dfs = ->(pos, comp) do
  visited[pos] = true
  G[pos].each do |to, z|
    if !visited[to]
      vals[to] = vals[pos] ^ z
      dfs.(to, comp << to)
    elsif vals[to] != vals[pos] ^ z
      puts -1
      exit
    end
  end
end

ans = Array.new(N, 0)
N.times do |i|
  next if visited[i]
  vals[i] = 0
  comp = [i]
  dfs.(i, comp)

  30.times do |j|
    count = comp.sum { vals[_1][j] }
    if 2 * count < comp.size
      comp.each do |k|
        ans[k] |= 1 << j if vals[k][j] == 1
      end
    else
      comp.each do |k|
        ans[k] |= 1 << j if vals[k][j].zero?
      end
    end
  end
end

puts ans.join(" ")
