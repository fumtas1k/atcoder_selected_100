# -
# ABC388/D
# 累積和:いもす法

N = gets.to_i
A = gets.split.map(&:to_i)

C = Array.new(N + 1, 0)

N.times do |i|
  if i != 0
    C[i] += C[i - 1]
    A[i] += C[i]
  end
  cnt = [N - i - 1, A[i]].min
  A[i] -= cnt
  C[i + 1] += 1
  C[i + cnt + 1] -= 1
end

puts A.join(" ")
