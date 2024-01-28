# -
# ABC336/E
# 動的計画法:その他

N = gets.to_i
A = gets.split.map(&:to_i)
A.unshift(0)
A << 0

# pyramid_l[i] := A[i]を頂点とした時、左側のみを見て頂点が最大となる値
pyramid_l = [0] * (N + 2)
# pyramid_r[i] := A[i]を頂点とした時、右側のみを見て頂点が最大となる値
pyramid_r = [0] * (N + 2)

1.upto(N) do |i|
  pyramid_l[i] = [pyramid_l[i - 1] + 1, A[i]].min
end

N.downto(1) do |i|
  pyramid_r[i] = [pyramid_r[i + 1] + 1, A[i]].min
end

puts pyramid_l.zip(pyramid_r).map(&:min).max
