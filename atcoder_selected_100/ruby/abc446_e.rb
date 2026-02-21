# -
# ABC446/E
# 数学的な問題
# 有効グラフ
# 包除原理

M, A, B = gets.split.map(&:to_i)
MAX = M * M

# 逆辺グラフを構築
# 順辺: (i,j) -> (j, (A*j + B*i) % M)
# 逆辺: (j, (A*j+B*i)%M) -> (i, j)
rev = Array.new(MAX) { [] }
M.times do |i|
  M.times do |j|
    k = (A * j + B * i) % M
    rev[j * M + k] << (i * M + j)
  end
end

# 除外するものをvisitedに記録
# i==0 または j==0 の状態を起点にBFS
visited = Hash.new(false)
queue = []
M.times do |i|
  [[0, i], [i, 0]].each do |j, k|
    v = j * M + k
    visited[v] = true
    queue << v
  end
end

# 除外するものに辿り着くものも除外する
until queue.empty?
  v = queue.shift
  rev[v].each do |u|
    next if visited[u]

    visited[u] = true
    queue << u
  end
end

puts MAX - visited.size
