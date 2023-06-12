# 57
# JOI2008YO/F
# 最短経路問題

N, K = gets.split.map(&:to_i)
QUERY = Array.new(K) { gets.split.map(&:to_i) }

FARE = Array.new(N + 1) { [Float::INFINITY] * (N + 1) }
(N + 1).times { FARE[_1][_1] = 0 }

QUERY.each do |query|
  case query[0]
  when 0
    a, b = query[1..]
    puts FARE[a][b] == Float::INFINITY ? -1 : FARE[a][b]
  when 1
    c, d, e = query[1..]
    next if FARE[c][d] <= e

    (N + 1).times do |i|
      (N + 1).times do |j|
        next if i == j
        FARE[i][j] = [FARE[i][c] + FARE[d][j] + e, FARE[i][d] + FARE[c][j] + e, FARE[i][j]].min
      end
    end
  end
end
