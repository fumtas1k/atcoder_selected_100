# 29
# ABC007/C
# 幅優先探索

R, C = gets.split.map(&:to_i)
SY, SX = gets.split.map(&:to_i).map(&:pred)
GY, GX = gets.split.map(&:to_i).map(&:pred)
G = Array.new(R) { gets.chomp.chars }

log = [[SY, SX, 0]]
G[SY][SX] = "#"
until log.empty?
  py, px, dist = log.shift
  if [py, px] == [GY, GX]
    puts dist
    exit
  end
  [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |dy, dx|
    ny, nx = py + dy, px + dx
    next if G[ny][nx] == "#"
    G[ny][nx] = "#"
    log << [ny, nx, dist + 1]
  end
end
