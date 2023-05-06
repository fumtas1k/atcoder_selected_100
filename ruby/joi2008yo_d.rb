# 9
# JOI2008YO/D
# 全探索:工夫して通り数を減らす全列挙

M = gets.to_i
S = Array.new(M) { gets.split.map(&:to_i) }
N = gets.to_i
T = N.times.map { [gets.split.map(&:to_i), true] }.to_h

T.each do |(tx, ty), _|
  dx, dy = tx - S[0][0], ty - S[0][1]
  if S.all? { |x, y| (x + dx).between?(0, 10 ** 6) && (y + dy).between?(0, 10 ** 6) && T[[x + dx, y + dy]] }
    puts [dx, dy].join(' ')
    break
  end
end
