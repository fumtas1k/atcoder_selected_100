# -
# ABC396/F
# 数学的問題
# 転倒数

require "ac-library-rb/fenwick_tree"

N, M = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
G = A.map.with_index.sort
ft = AcLibraryRb::FenwickTree.new(M)

ans = Array.new(M, 0)
A.each do |a|
  ans[0] += ft.sum(a + 1, M)
  ft.add(a, 1)
end

# 最初に Ai = M - 1 が 0　になっていく
(M - 1).downto(1) do |a|
  ans[M - a] = ans[M - a - 1]
  while !G.empty? && G[-1][0] == a
    _, i = G.pop
    # Ai = a は 0になるので、Ai 以外の要素は 0以上になっている
    # つまり、 i個は Ai　より左にあるので転倒数となり、 M - 1 - i 個は右にあるので転倒数ではなくなる
    ans[M - a] += i - (N - 1 - i)
  end
end

puts ans
