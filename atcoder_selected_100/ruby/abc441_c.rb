# -
# ABC441/C
# 貪欲法

N, K, X = gets.split.map(&:to_i)
A = gets.split.map(&:to_i).sort.reverse

# N - K + 1　個以上を選べば、必ず日本酒が1つはある。
# 大きい方から　N - K + 1個選べば、日本酒をXmL以上飲む確率はが上がる
idx = N - K
sum = 0
while idx < N
  sum += A[idx]
  if sum >= X
    puts idx + 1
    exit
  end
  idx += 1
end

puts -1
