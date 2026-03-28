# -
# AWC0014/E
# その他
# Fenwick Tree
# いもす法
# 累積和
# 区間更新, 区間和

require "ac-library-rb/fenwick_tree"

N, Q = gets.split.map(&:to_i)
bit1 = AcLibraryRb::FenwickTree.new(N)
bit2 = AcLibraryRb::FenwickTree.new(N)

# [l, r) に v を加算する
add_range = -> (l, r, v) do
  bit1.add(l, v)
  bit1.add(r, -v) if r < N
  bit2.add(l, v * l)
  bit2.add(r, -v * r) if r < N
end

# [0, x) の要素の和を求める
prefix_sum = -> x do
  return 0 if x <= 0

  # a[i] = d[0] + d[1] + ... + d[i]
  # a[0] + a[1] + .. + a[x - 1] = ((x - 1) * d[0] + (x - 2) * d[1] + ... + 0 * d[x - 1]) + (d[0] + d[1] + ... + d[x - 1])
  # = x * (d[0] + d[1] + ... + d[x - 1]) - (0 * d[0] + 1 * d[1] + ... + (x - 1) * d[x - 1])
  bit1.sum(0, x) * x - bit2.sum(0, x)
end

gets.split.map(&:to_i).each_with_index do |a, i|
  add_range.(i, i + 1, a)
end

ans = []
Q.times do
  case gets.split.map(&:to_i)
  in [1, l, r, v]
    add_range.(l - 1, r, v)
  in [2, l, r]
    ans << prefix_sum.(r) - prefix_sum.(l - 1)
  end
end

puts ans
