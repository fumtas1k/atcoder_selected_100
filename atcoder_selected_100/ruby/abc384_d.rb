# -
# 全探索:全列挙
# 尺取法
# 累積和
# ループ

N, S = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
# 右端と左端を使用する場合も考えられるので、2N+1個の要素を持つ累積和を作成
csum = [*A, *A].reduce([0]) { |acc, a| acc << acc[-1] + a }
sum = S % csum[N]

r = 0
(2 * N + 1).times do |l|
  r += 1 while r < 2 * N && csum[r] - csum[l] < sum
  if csum[r] - csum[l] == sum
    puts "Yes"
    exit
  end
end

puts "No"
