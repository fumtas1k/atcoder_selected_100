# -
# ABC359/E
# その他
# スタック

N = gets.to_i
H = gets.split.map(&:to_i)

# 水槽の水の量(高さ、幅）を記録する。
# [height, width]
stack = [[0, 0]]
ans = Array.new(N + 1, 0)

H.each_with_index do |h, i|
  ans[i + 1] = ans[i]
  w = 1
  while !stack.empty? && stack[-1][0] < h
    height, width = stack.pop
    w += width
    # 直近でh以上の高さの板との間をhの高さまで水で満たすため
    # すでに満たされている水を満たすための時間を引く
    ans[i + 1] -= height * width
  end
  stack << [h, w]
  ans[i + 1] += h * w
end

# ans[i] = i番目の板の手前までを満たす時刻
# したがって、i番目の水槽に水が到達するのは ans[i] + 1
puts ans[1..].map(&:succ).join(" ")
