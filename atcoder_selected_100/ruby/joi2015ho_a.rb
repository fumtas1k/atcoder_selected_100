# 83
# JOI2015HO/A
# いもす法

N, M = gets.split.map(&:to_i)
P = gets.split.map(&:to_i).map(&:pred)
ABC = Array.new(N - 1) { gets.split.map(&:to_i) }

# imos法で路線を通る回数をカウント
cnt = [0] * N
(M - 1).times do |i|
  min, max = [P[i], P[i + 1]].minmax
  cnt[min] += 1
  cnt[max] -= 1
end
(N - 1).times { cnt[_1 + 1] += cnt[_1] }

ans = 0
cnt[0, N - 1].each_with_index do |j, i|
  next if j.zero?
  a, b, c = ABC[i]
  ans += [j * a, j * b + c].min
end

puts ans
