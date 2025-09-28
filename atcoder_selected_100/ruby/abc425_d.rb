# -
# ABC425/D
# 幅優先探索
# 多始点 BFS
# 同時更新

INF = 1 << 60
H, W = gets.split.map(&:to_i)
S = Array.new(H) { gets.chomp.chars }

# 多始点BFSで黒マスから1マスずつ白マスを黒マスに変えていく
# 同時更新するために、黒マスの座標をキューに入れておき、そこから探索していく
steps = Array.new(H) { [INF] * W }
blacks = []
H.times do |i|
  W.times do |j|
    next if S[i][j] == "."
    blacks << [i, j]
    steps[i][j] = 0
  end
end

ans = 0
until blacks.empty?
  r, c = blacks.shift
  ans += 1
  [[0, 1], [1, 0], [0, -1], [-1, 0]].each do |dr, dc|
    nr, nc = r + dr, c + dc
    next unless nr.between?(0, H - 1) && nc.between?(0, W - 1) && steps[nr][nc] == INF
    black_cnt = 0
    [[0, 1], [1, 0], [0, -1], [-1, 0]].each do |dr1, dc1|
      nr1, nc1 = nr + dr1, nc + dc1
      next unless nr1.between?(0, H - 1) && nc1.between?(0, W - 1) && steps[nr1][nc1] <= steps[r][c]
      black_cnt += 1
    end
    next unless black_cnt == 1
    blacks << [nr, nc]
    steps[nr][nc] = steps[r][c] + 1
  end
end

puts ans
