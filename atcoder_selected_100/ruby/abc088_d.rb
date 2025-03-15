# 33
# ABC88/D
# 幅優先探索

HASH, DOT = "#.".bytes

H, W = gets.split.map(&:to_i)
S = Array.new(H) { gets.chomp.bytes }
dot_cnt = S.sum { _1.count(DOT) }

log = [[0, 0, 1]]
until log.empty?
  r, c, cnt = log.shift
  if [r, c] == [H - 1, W - 1]
    puts dot_cnt - cnt
    exit
  end
  S[r][c] = HASH

  [[r - 1, c], [r + 1, c], [r, c - 1], [r, c + 1]].each do |nr, nc|
    next unless nr.between?(0, H - 1) && nc.between?(0, W - 1) && S[nr][nc] == DOT
    S[nr][nc] = HASH
    log << [nr, nc, cnt + 1]
  end
end

puts -1
