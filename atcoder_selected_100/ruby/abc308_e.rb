# -
# ABC308/E
# 累積和
# MEX
# 3つ組は真ん中固定
# セグメント木

require "ac-library-rb/segtree"
include AcLibraryRb

INF = 1 << 60
M, E, X = "MEX".bytes

# 事前にMEXの全パターンを計算
MEX = Hash.new
[*0 .. 2].repeated_permutation(3) do |abc|
  st = SegTree.new([*0 .. 3], INF) { |a, b| [a, b].min }
  abc.each { st.set(_1, INF) }
  MEX[abc] = st.all_prod
end

N = gets.to_i
A = gets.split.map(&:to_i)
S = gets.chomp.bytes
msum = Array.new(3, 0)
xsum = Array.new(3, 0)

# Xのtotalを事前に計算しておく
A.each_with_index do |a, i|
  xsum[a] += 1 if S[i] == X
end

ans = 0
A.each_with_index do |a, i|
  case S[i]
  when M
    msum[a] += 1
  when E
    ans += [*0 .. 2].repeated_permutation(2).sum do |(m, x)|
      MEX[[m, a, x]] * msum[m] * xsum[x]
    end
  when X
    xsum[a] -= 1
  end
end

puts ans
