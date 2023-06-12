# 61
# ABC012/D
# 最短経路問題:ワーシャルフロイド法

N, M = gets.split.map(&:to_i)
G = Array.new(N) { [Float::INFINITY] * N }
N.times { G[_1][_1] = 0 }
M.times do
  a, b, t = gets.split.map(&:to_i)
  G[a - 1][b - 1] = t
  G[b - 1][a - 1] = t
end

N.times do |k|
  N.times do |i|
    N.times do |j|
      G[i][j] = [G[i][j], G[i][k] + G[k][j]].min
    end
  end
end

puts G.map { _1.max }.min
