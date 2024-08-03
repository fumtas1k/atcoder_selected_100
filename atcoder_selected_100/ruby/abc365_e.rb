# -
# ABC365/E
# ビット
# XOR
# 累積和

# XOR を扱う問題では、各bit毎に考えることが有効
N = gets.to_i
A = gets.split.map(&:to_i)

# A[i]も加算してしまうので、事前に引いておく
ans = - A.sum
# A[i]が最大10^8なので、2^30まで考えれば十分
31.times do |i|
  cxor = A.reduce([0]) { |acc, a| acc << (acc[-1] ^ a[i]) }
  # b ^ c = a ^ b ^ c ^ a という性質を利用
  # A[i][l] ^ A[i][l+1] ^ ... ^ A[i][r] = cxor[r+1] ^ cxor[l]
  # cxor[r+1] ^ cxor[l] = 1 となるような(l, r)の組み合わせは、どちらかが1で、もう片方が0である必要がある
  ans += cxor.partition(&:zero?).map(&:size).reduce(:*) * (1 << i)
end

puts ans
