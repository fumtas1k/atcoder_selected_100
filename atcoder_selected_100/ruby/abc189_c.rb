# -
# スタック
# ヒストグラム最大長方形

N = gets.to_i
A = gets.split.map(&:to_i)
# 空にならないように先頭に最小値 を追加
A.unshift(-1)
# 最後の要素も取り出すために末尾に最小値 を追加
A << -1

stack = []
max_area = 0

A.each_with_index do |a, i|
  while !stack.empty? && A[stack[-1]] > a
    height = A[stack.pop]
    # 高さA[stack.pop]の長方形の幅は、stack[-1] + 1 から i - 1 まで
    width = (i - 1) - stack[-1]
    max_area = [max_area, height * width].max
  end
  stack << i
end

puts max_area
