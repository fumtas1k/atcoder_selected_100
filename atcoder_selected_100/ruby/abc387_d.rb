# -
# 幅優先探索
# パリティ
# 状態管理

HASH, DOT, START, GOAL = "#.SG".bytes
INF = 10 ** 18

H, W = gets.split.map(&:to_i)
S = []
sr = sc = gr = gc = 0
H.times do |i|
  row = gets.chomp.bytes
  row.each_with_index do |c, j|
    case c
    when START
      sr, sc = i, j
    when GOAL
      gr, gc = i, j
    end
  end
  S << row
end

moves = [[[1, 0], [-1, 0]], [[0, 1], [0, -1]]]

ans = INF

# Hash[r, c, d]で管理し、一気に計算するとTLEになる
# Hash[r, c, d]よりArray[r][c]の方が高速
# queueも、数が多くなると遅くなるので2回に分ける
# 2回のBFSで解く

2.times do |i|
  dist = Array.new(H) { Array.new(W, INF) }
  dist[sr][sc] = 0
  queue = [[sr, sc]]
  until queue.empty?
    r, c = queue.shift
    # 市松模様の塗り分け
    moves[(r + c + i) % 2].each do |dr, dc|
      nr, nc = r + dr, c + dc
      next unless nr.between?(0, H - 1) && nc.between?(0, W - 1) && S[nr][nc] != HASH && dist[nr][nc] == INF
      dist[nr][nc] = dist[r][c] + 1
      queue << [nr, nc]
    end
  end
  ans = [ans, dist[gr][gc]].min
end

puts ans == INF ? -1 : ans
