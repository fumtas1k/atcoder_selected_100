# 89
# JOI2013HO/1
# 圧縮

N = gets.to_i
A = gets.split.map(&:to_i)

alternating = [1]
(N - 1).times do |i|
  if A[i + 1] != A[i]
    alternating[-1] += 1
  else
    alternating << 1
  end
end

# 交互列が2つの時は1つを反転させれば全てが交互にできる
if alternating.size <= 2
  puts N
else
  # 交互列が3つ以上の時は、連続する3つを選び真ん中を反転させれば良いので、連続する交互列3つの最大の長さを求める
  puts 0.upto(alternating.size - 3).map { alternating[_1, 3].sum }.max
end
