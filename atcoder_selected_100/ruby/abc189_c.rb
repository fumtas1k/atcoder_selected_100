# -
# スタック
# ヒストグラム最大長方形

N = gets.to_i
# 最後の要素も取り出すために末尾に番兵を追加
A = gets.split.map(&:to_i) << -1
# stackが空にならないようにAの先頭に番兵を追加
A.unshift(-1)
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
