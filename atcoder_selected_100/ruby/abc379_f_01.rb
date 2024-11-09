# -
# ABC379/F
# スタック
# ヒストグラム最大長方形
# Fenwick Tree

require "ac-library-rb/fenwick_tree"

N, Q = gets.split.map(&:to_i)
H = gets.split.map(&:to_i)
LRJ = Array.new(Q) { [*gets.split.map(&:to_i).map(&:pred), _1] }.group_by(&:first)

ans = []
stack = []
ft = AcLibraryRb::FenwickTree.new(N)
(N - 1).downto(0) do |i|
  LRJ[i]&.each do |_, r, j|
    ans[j] = ft.sum(r + 1, N)
  end
  ft.add(stack.pop, -1) while !stack.empty? && H[stack[-1]] < H[i]
  stack << i
  ft.add(i, 1)
end

puts ans
