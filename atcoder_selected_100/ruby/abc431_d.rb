# -
# ABC431/E
# 幅優先探索
# 01-BFS

direct_r = [0, 1, -1, 0]
direct_c = [1, 0, 0, -1]
trans = {
  "A" => [0, 1, 2, 3],
  "B" => [1, 0, 3, 2],
  "C" => [2, 3, 0, 1],
}
INF = 1 << 60
T = gets.to_i

ans = []
T.times do
  h, w = gets.split.map(&:to_i)
  ss = Array.new(h) { gets.chomp }
  # [r, c, dir, cost]
  deque = [[0, -1, 0, 0]]

  # HashにするとTLE
  costs = Array.new(h) { Array.new(w) { Array.new(4, INF) } }
  until deque.empty?
    r, c, dir, cost = deque.shift

    if r == h - 1 && c == w - 1 && dir.zero?
      ans << cost
      break
    end
    nr, nc = r + direct_r[dir], c + direct_c[dir]
    next unless nr.between?(0, h - 1) && nc.between?(0, w - 1)

    trans.each do |k, to|
      ndir = to[dir]
      if ss[nr][nc] == k
        next if cost >= costs[nr][nc][ndir]
        costs[nr][nc][ndir] = cost
        deque.unshift [nr, nc, ndir, cost]
      else
        next if cost + 1 >= costs[nr][nc][ndir]
        costs[nr][nc][ndir] = cost + 1
        deque << [nr, nc, ndir, cost + 1]
      end
    end
  end
end

puts ans
