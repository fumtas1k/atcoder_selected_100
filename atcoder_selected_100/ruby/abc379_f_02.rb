# -
# ABC379/F
# スタック
# ヒストグラム最大長方形
# 二分探索法

N, Q = gets.split.map(&:to_i)
H = gets.split.map(&:to_i)
LRJ = Array.new(Q) { [*gets.split.map(&:to_i).map(&:pred), _1] }.group_by(&:first)

ans = []
stack = []

(N - 1).downto(0) do |i|
  LRJ[i]&.each do |_, r, j|
    idx = stack.bsearch_index { _1 <= r } || stack.size
    ans[j] = idx
  end
  stack.pop while !stack.empty? && H[stack[-1]] < H[i]
  stack << i
end

puts ans
