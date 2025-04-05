# -
# ABC400/C
# 二分探索法
# 平方根を求める

N = gets.to_i
ans = 0
1.upto(59) do |i|
  div = N / 2.pow(i)
  break if div.zero?
  # Math.sqrt(div).to_i は丸誤差があるので、2分探索で求める
  cnt = (2 .. div + 1).bsearch { _1.pow(2) > div } - 1
  # 偶数は除外することで重複を削除
  ans += (cnt + 1) / 2
end

puts ans
