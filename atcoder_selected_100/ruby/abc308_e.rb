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
mex = Hash.new
[*0 .. 2].repeated_permutation(3) do |abc|
  st = SegTree.new([*0 .. 3], INF) { |a, b| [a, b].min }
  abc.each { st.set(_1, INF) }
  mex[abc] = st.all_prod
end

N = gets.to_i
A = gets.split.map(&:to_i)
S = gets.chomp.bytes
msum = [0] * 3
xsum = [0] * 3

# Xのtotalを事前に計算しておく
A.zip(S) { xsum[_1] += 1 if _2 == X }

ans = 0
A.zip(S) do |a, s|
  case s
  when M
    msum[a] += 1
  when E
    e = a
    [*0 .. 2].repeated_permutation(2) do |m, x|
      ans += mex[[m, e, x]] * msum[m] * xsum[x]
    end
  when X
    xsum[a] -= 1
  end
end

puts ans
