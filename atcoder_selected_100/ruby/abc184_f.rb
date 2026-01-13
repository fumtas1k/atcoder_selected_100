# -
# ABC184/F
# 全探索:全列挙
# 半分全列挙
# 尺取法

def enumerate_sums(arr)
  dp = Hash.new(false)
  dp[0] = true
  arr.each do |a|
    ep = dp.dup
    ep.each do |k, _|
      dp[k + a] = true
    end
  end
  dp.keys.sort
end

N, T = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

first_half = A[0, N / 2]
second_half = A[N / 2 ..]
first_times = enumerate_sums(first_half)
second_times = enumerate_sums(second_half).reverse

ans = 0
i = 0
first_times.each do |t|
  i += 1 while i < second_times.size && t + second_times[i] > T
  break if i == second_times.size
  ans = [ans, t + second_times[i]].max
end

puts ans
