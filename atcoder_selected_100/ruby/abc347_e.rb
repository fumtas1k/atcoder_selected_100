# -
# ABC347/E
# 累積和
# 横ではなく縦で考える

require "set"
N, Q = gets.split.map(&:to_i)
X = gets.split.map(&:to_i).map(&:pred)

A = [0] * N
S = Set.new
csum = 0
# 要素数の累積和を計算する
# 削除時に累積和をAに足す
# 追加時には累積和をAから引いておく
# 累積和はその時の累積和のみ知りたいので配列の必要なし
X.each do |x|
  if S.include?(x)
    S.delete(x)
    A[x] += csum
  else
    S << x
    A[x] -= csum
  end
  csum += S.size
end

# 削除されなかった要素は要素数の累積和の加算がされていないので最後に行う
S.each { A[_1] += csum }

puts A.join(" ")
