# -
# ABC400/D
# 幅優先探索
# 0-1BFS

HASH, DOT = "#.".bytes
INF = 10 ** 18
H, W = gets.split.map(&:to_i)
S = Array.new(H) { gets.chomp.bytes }
sr, sc, tr, tc = gets.split.map(&:to_i).map(&:pred)
# priority queueを用いるとむしろ遅くなる
deque = [[sr, sc, 0]]
log = Array.new(H) { Array.new(W, INF) }
log[sr][sc] = 0

until deque.empty?
  r, c, cnt = deque.shift
  if r == tr && c == tc
    puts cnt
    exit
  end
  next if log[r][c] < cnt
  [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |dr, dc|
    nr, nc = r + dr, c + dc
    if nr.between?(0, H - 1) && nc.between?(0, W - 1)
      if S[nr][nc] == DOT
        if log[nr][nc] > cnt
          deque.unshift([nr, nc, cnt])
          log[nr][nc] = cnt
        end
      else
        next_cnt = cnt + 1
        if log[nr][nc] > next_cnt
          deque << [nr, nc, next_cnt]
          log[nr][nc] = next_cnt
        end
        nr, nc = nr + dr, nc + dc
        # S[nr][nc] == DOT の場合、こちらで加えると重複するので除外する
        if nr.between?(0, H - 1) && nc.between?(0, W - 1) && S[nr][nc] == HASH && log[nr][nc] > next_cnt
          deque << [nr, nc, next_cnt]
          log[nr][nc] = next_cnt
        end
      end
    end
  end
end
