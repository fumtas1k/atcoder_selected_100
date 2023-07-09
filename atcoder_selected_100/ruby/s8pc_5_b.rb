# 90
# S8PC-5/B
# その他

N, M = gets.split.map(&:to_i)
xy = []
r = []
if N != 0
  xy, r = Array.new(N) { gets.split.map(&:to_i) }.map { [_1[0, 2], _1[2]]}.transpose
end
if M != 0
  xy += Array.new(M) { gets.split.map(&:to_i) }
end

[*0 ... N + M].combination(2) do |i, j|
  next if i < N && j < N
  d = Math.sqrt((xy[i][0] - xy[j][0]) ** 2 + (xy[i][1] - xy[j][1]) ** 2)
  if i < N
    r << d - r[i]
  else
    r << d / 2
  end
end

puts format("%.15f", r.min)
