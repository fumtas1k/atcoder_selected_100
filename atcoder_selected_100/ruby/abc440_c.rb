# -
# ABC440/C
# 全探索:全列挙
# 尺取法

ans = []
gets.to_i.times do
  _, w = gets.split.map(&:to_i)
  cs = gets.split.map(&:to_i)
  # 余でまとめる
  remain_to_sum = cs.map.with_index(1) { [_2 % (2 * w), _1] }.group_by(&:first).transform_values { |v| v.sum(&:last) }
  remain_to_sum.default = 0
  sums = [0]
  # 円循環なので2周分見る
  (2 * 2 * w).times do |i|
    if i < w
      sums[0] += remain_to_sum[i % (2 * w)]
    else
      sums << sums[-1] + remain_to_sum[i % (2 * w)] - remain_to_sum[i - w]
    end
  end
  ans << sums.min
end

puts ans
