# -
# ABC221/D
# いもす法

N = gets.to_i
days = Hash.new(0)
N.times do
  a, b = gets.split.map(&:to_i)
  days[a] += 1
  days[a + b] -= 1
end

pre = cnt = 0
ans = Array.new(N + 1, 0)

days.sort.each do |now, v|
  # pre から now - 1 まではログインした人数が一定
  ans[cnt] += now - pre
  cnt += v
  pre = now
end

puts ans[1, N].join(' ')
