# 30
# JOI2011YO/E
# 幅優先探索

H, W, N = gets.split.map(&:to_i)
MAP = []
cheeses = []
H.times do |i|
  MAP << gets.chomp.chars
  MAP[i].each_with_index do |c, j|
    cheeses[0] = [i , j] if c == "S"
    cheeses[c.to_i] = [i, j] if c.to_i > 0
  end
end

ans = 0
# チーズの硬さの昇順に最短を移動することが最短
N.times do |i|
  time = Array.new(H) { [-1] * W }
  time[cheeses[i][0]][cheeses[i][1]] = 0

  # [pos, time]
  log = [cheeses[i]]

  until log.empty?
    r, c = log.shift
    if [r, c] == cheeses[i + 1]
      ans += time[r][c]
      break
    end

    [[1, 0], [0, 1], [-1, 0], [0, -1]].each do |dr, dc|
      nr, nc = r + dr, c + dc
      # 範囲外、障害物、1度訪問した場所は除外
      next if !nr.between?(0, H - 1) || !nc.between?(0, W - 1) || MAP[nr][nc] == "X" || time[nr][nc] >= 0
      time[nr][nc] = time[r][c] + 1
      log << [nr, nc]
    end
  end
end

puts ans
