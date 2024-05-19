# -
# ABC354/F
# LIS
# 前後を考える

def calc_subseq_size(arr, &block)
  subseq = []
  subseq_size = []
  arr.each_with_index do |a, i|
    idx = subseq.bsearch_index { block.call(_1, a) } || subseq.size
    subseq[idx] = a
    subseq_size << idx + 1
  end
  subseq_size
end

T = gets.to_i
ans = []
T.times do
  n = gets.to_i
  arr = gets.split.map(&:to_i)
  # 最後の要素がarr_iであるLISの長さ
  subseq_size = calc_subseq_size(arr, &:>=)
  lis_size = subseq_size.max

  # 最後の要素がarr_(n - i - 1) であるLDSの長さ
  # 関数を使い回すため、逆順にして単調減少部分列で考える
  rev_sebseq_size = calc_subseq_size(arr.reverse, &:<=)

  included_lis = n.times.filter_map do |i|
    i + 1 if subseq_size[i] + rev_sebseq_size[n - i - 1] - 1 == lis_size
  end
  ans << included_lis.size
  ans << included_lis.join(" ")
end

puts ans
