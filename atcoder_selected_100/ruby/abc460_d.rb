# -
# ABC460/D
# 幅優先探索
# 多始点BFS(Multi-source BFS)

# 範囲内か
# between?を使用するとTLEするため作成
def inside?(r, c, h, w)
  0 <= r && r < h && 0 <= c && c < w
end

INF = 1 << 60 # 偶数にしておく
HASH, DOT = "#.".bytes
H, W = gets.split.map(&:to_i)
S = Array.new(H) { gets.chomp.bytes }
directs = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]
second = Array.new(H) { [DOT] * W }

H.times do |i|
  W.times do |j|
    next if S[i][j] == HASH
    directs.each do |di, dj|
      ni, nj = i + di, j + dj
      if inside?(ni, nj, H, W) && S[ni][nj] == HASH
        second[i][j] = HASH
        break
      end
    end
  end
end

# 1回の操作で黒になったマスに隣接するマスには必ず白が存在する
# つまり、その後は、白と黒を繰り返す
# 繰り返すますに隣接するマスも白と黒を繰り返す
# そのタイミングが、偶数か奇数かを判定するために1回目に黒となったマスからの最短距離を求める
dists = Array.new(H) { [INF] * W }
queue = []
H.times do |i|
  W.times do |j|
    next if second[i][j] == DOT
    dists[i][j] = 0
    queue << [i, j]
  end
end
until queue.empty?
  i, j = queue.shift
  directs.each do |di, dj|
    ni, nj = i + di, j + dj
    next unless inside?(ni, nj, H, W) && dists[ni][nj] == INF
    dists[ni][nj] = dists[i][j] + 1
    queue << [ni, nj]
  end
end

ans = Array.new(H) { Array.new(W) }
H.times do |i|
  W.times do |j|
    ans[i][j] = dists[i][j] % 2 == 0 ? "." : "#"
  end
end
puts ans.map(&:join)
