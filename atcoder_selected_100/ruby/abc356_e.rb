# -
# ABC356/E
# 累積和
# 答えから考える

N = gets.to_i
A = gets.split.map(&:to_i).tally
A.default = 0
MAX = A.keys.max

ccnt = (1 .. MAX).reduce([0]) {|acc, i| acc << acc[-1] + A[i] }

ans = 0
A.keys.sort.each do |min|
  min_cnt = A[min]
  min.step(MAX, min).with_index(1) do |max, i|
    ans += i * min_cnt * (ccnt[[max + min - 1, MAX].min] - ccnt[max - 1])
  end
  # 本来、同じ値同士の組み合わせの数は、min_cnt * (min_cnt - 1) / 2 のため、不要な部分を引く
  # min_cnt * (min_cnt - 1) / 2　 = min_cnt ** 2 - (min_cnt * (min_cnt + 1) / 2)
  ans -= min_cnt * (min_cnt + 1) / 2
end

puts ans
