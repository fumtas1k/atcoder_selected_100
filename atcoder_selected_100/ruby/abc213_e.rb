# -
# ABC213/E
# 幅優先探索
# 01-BFS

DOT, HASH = ".#".bytes
INF = 10 ** 6
DIRECT1 = [[1, 0], [0, 1], [-1, 0], [0, -1]]
DIRECT2 = [*-2..2].product([*-2..2]).reject { |dr, dc| dr.abs + dc.abs > 3 || (dr.zero? && dc.zero?) }

H, W = gets.split.map(&:to_i)
S = Array.new(H) { gets.chomp.bytes }

counts = Array.new(H) { [INF] * W }
counts[0][0] = 0
queue = [[0, 0, 0]]
until queue.empty?
  r, c, count = queue.shift
  next if counts[r][c] < count

  if [r, c] == [H - 1, W - 1]
    puts counts[H - 1][W - 1]
    exit
  end

  # 破壊なし
  DIRECT1.each do |dr, dc|
    nr, nc = r + dr, c + dc
    next unless nr.between?(0, H - 1) && nc.between?(0, W - 1) && S[nr][nc] == DOT
    next if counts[nr][nc] <= count
    counts[nr][nc] = count
    queue.unshift([nr, nc, count])
  end

  # 破壊あり
  DIRECT2.each do |dr, dc|
    nr, nc = r + dr, c + dc
    next unless nr.between?(0, H - 1) && nc.between?(0, W - 1)
    next if counts[nr][nc] <= count + 1
    counts[nr][nc] = count + 1
    queue << [nr, nc, count + 1]
  end
end
