# -
# ABC375/D
# 累積和

S = gets.chomp.chars
groups = Hash.new { |h, k| h[k] = [] }
group_sum = Hash.new(0)
ans = 0
S.each_with_index do |s, i|
  if groups[s].empty?
    groups[s] << i
    group_sum[s] += i
  else
    size = groups[s].size
    ans += size * (i - 1) - group_sum[s]
    group_sum[s] += i
    groups[s] << i
  end
end

puts ans
