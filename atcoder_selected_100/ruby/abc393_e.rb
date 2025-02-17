# -
# ABC393/E
# 約数列挙 NlnN

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
M = A.max
# tallyは遅いので配列を使用する
tally = Array.new(M + 1, 0)
A.each { tally[_1] += 1 }

# multiple_cnt[i] = iの倍数の個数
multiple_cnt = Array.new(M + 1, 0)
multiple_cnt[1] = N
(2 .. M).each do |i|
  j = i
  # stepを使用すると遅いのでwhileを使用する
  while j <= M
    multiple_cnt[i] += tally[j]
    j += i
  end
end

# divisor_max[i] = iを含むK個の要素の約数の最大値
divisor_max = Array.new(M + 1, 1)
(2 .. M).each do |i|
  next if multiple_cnt[i] < K
  j = i
  # stepを使用すると遅いのでwhileを使用する
  while j <= M
    divisor_max[j] = [divisor_max[j], i].max
    j += i
  end
end

puts A.map { divisor_max[_1] }
