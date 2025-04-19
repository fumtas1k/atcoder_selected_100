# -
# ABC402/D
# 数学的問題
# 余事象
# 平行条件, 中点

N, M = gets.split.map(&:to_i)
# 直線と直角な円の中心に向かう直線は中点を通る
# 直線が平行である時、共通の中点を持つ
# つまり、(Ai + Bi) % N が同じものは平行
AB = Array.new(M) { gets.split.map(&:to_i).map(&:pred).sum % N }.tally

puts M * (M - 1) / 2 - AB.values.sum { _1 * (_1 - 1) / 2 }
