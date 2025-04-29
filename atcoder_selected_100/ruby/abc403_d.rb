# -
# ABC403/D
# 動的計画法:その他

M = 10 ** 6
N, D = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
tally = A.tally
tally.default = 0

if D.zero?
  puts N - tally.size
  exit
end

def calc(arr)
  return 0 if arr.empty?
  # dp[i] = i番目までの最小コスト. 1-indexed
  # 1番目の最小コストは 0
  dp = Array.new(arr.size + 1, 0)
  1.upto(arr.size - 1) do |i|
    # i + 1番目(arr[i])を消すか、i番目(arr[i - 1])を消すか
    dp[i + 1] = [dp[i] + arr[i], dp[i - 1] + arr[i - 1]].min
  end
  dp.last
end

# Dの倍数を消すか判断するため、スタートは、0..D-1まで
ans = D.times.sum do |i|
  i.step(M, D).map { tally[_1] }.then { calc(_1) }
end

puts ans
