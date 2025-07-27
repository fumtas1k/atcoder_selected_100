# -
# ABC416/D
# 全探索:全列挙
# 尺取法
# 除くものを考える

ans = gets.to_i.times.map do
  n, m = gets.split.map(&:to_i)
  as = gets.split.map(&:to_i).sort.reverse
  bs = gets.split.map(&:to_i).sort

  bi = 0
  # a + b >= m となる組の個数を求める
  over_cnt = 0
  as.each do |a|
    bi += 1 while bi < n && a + bs[bi] < m
    break if bi == n
    over_cnt += 1
    bi += 1
  end
  as.sum + bs.sum - over_cnt * m
end

puts ans
