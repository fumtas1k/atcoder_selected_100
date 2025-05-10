# -
# ABC405/D
# 幅優先探索
# 多始点 BFS

INF = 1 << 60
# loopの中でcase文でマークを判定しているとTLEするため、あらかじめマークを定義しておく
DIRECTIONS = [[-1, 0, "v"], [1, 0, "^"], [0, -1, ">"], [0, 1, "<"]]

H, W = gets.split.map(&:to_i)
S = []
log = []

H.times do |i|
  S << gets.chomp.chars
  S[i].each_with_index do |c, j|
    next unless c == "E"
    log << [i, j]
  end
end

until log.empty?
  r, c = log.shift

  DIRECTIONS.each do |dr, dc, mark|
    nr, nc = r + dr, c + dc
    next unless nr.between?(0, H - 1) && nc.between?(0, W - 1) && S[nr][nc] == "."
    S[nr][nc] = mark
    log << [nr, nc]
  end
end

puts S.map { _1.join }.join("\n")
