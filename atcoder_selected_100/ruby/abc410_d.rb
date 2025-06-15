# -
# ABC410/D
# 動的計画法:ビットDP

MAX = 1 << 10
N, M = gets.split.map(&:to_i)
G = Array.new(N) { [] }
M.times do
  a, b, w = gets.split.map(&:to_i)
  G[a - 1] << [b - 1, w]
end

bits = Array.new(N) { Array.new(MAX, false) }
bits[0][0] = true

dfs = -> (pos = 0, bit = 0) do
  G[pos].each do |nex, w|
    next if bits[nex][bit ^ w]
    bits[nex][bit ^ w] = true
    dfs.(nex, bit ^ w)
  end
end

dfs.()

ans = 0
ans += 1 while ans < MAX && !bits[-1][ans]
puts ans == MAX ? -1 : ans
