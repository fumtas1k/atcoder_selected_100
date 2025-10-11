# -
# ABC426/D
# その他
# 最長連続区間
# ランレングス圧縮

ans = gets.to_i.times.map do
  n = gets.to_i
  ss = gets.chomp.chars.map(&:to_i)
  # wind_max[i] = iが連続する区間の最大値
  wind_max = [0] * 2
  cnt = [0] * 2
  cnt[1] = ss.sum
  cnt[0] = n - cnt[1]
  pre = 0
  # 番兵を追加しておく
  (ss + [-1]).each_with_index do |c, i|
    next if ss[pre] == c
    wind_max[ss[pre]] = [i - pre, wind_max[ss[pre]]].max
    pre = i
  end
  # 例えば、0にする場合、1は1度反転、0は最長連続区間以外2度反転する必要がある
  2.times.map { 2 * (cnt[_1] - wind_max[_1]) + cnt[1 - _1] }.min
end

puts ans
