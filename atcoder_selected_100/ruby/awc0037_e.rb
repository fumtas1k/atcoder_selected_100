# -
# AWC0037/E
# その他
# 単調スタック
# NGE (Next Greater Element)

N = gets.to_i
H = gets.split.map(&:to_i)

# stack[i] = [iの身長, range_min]
# range_min スタック上で自分のすぐ上にある要素の位置の直前までの区間の最小値
stack = []
ans = 0

H.each do |h|
  while !stack.empty? && stack[-1][0] < h
    sh, smin = stack.pop
    ans += smin
    next if stack.empty?
    # pop 時に区間最小値を伝搬させる
    stack[-1][1] = [stack[-1][1], smin].min
  end
  stack << [h, h]
end

puts ans

