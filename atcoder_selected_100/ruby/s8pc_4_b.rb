# 14
# S8PC4/B
# ビット全探索

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

# heighest[i] = [i番目未満で最も高い高さ + 1, i番目の高さ].max
heighest = []
h = 0
A.each do |a|
  h = [h, a].max
  heighest << h
  h += 1 if h == a
end

ans = []
# 0番目は必ず見えるので、0番目を除いて少なくともK - 1個が単調増加となる場合の金額を考える
[*1 ... N].combination(K - 1) do |comb|
  ans << 0
  h = 0
  comb.each do |i|
    h = [h, heighest[i]].max
    ans[-1] += h - A[i]
    h += 1
  end
end

puts ans.min
