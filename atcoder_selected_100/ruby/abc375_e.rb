# -
# ABC375/E
# 動的計画法
# ループを1つ減らす

# Float::INFINITYはTLEするため使用しない
INF = 10 ** 3
N = gets.to_i
AB = Array.new(N) { gets.split.map(&:to_i) }
B_SUM = AB.sum(&:last)
AVG, mod = B_SUM.divmod(3)

if mod != 0
  puts -1
  exit
end

# dp[j][k]= チーム1の強さがj, チーム2の強さがkの時の変更人数の最小値
# チーム3は自ずと決まるのでチーム1, 2のみ状態を持たせる
# dp[i][j][k]　とすると、TLEする
dp = Array.new(AVG + 1) { Array.new(AVG + 1, INF) }
dp[0][0] = 0

AB.each_with_index do |(a, b), i|
  ep = Array.new(AVG + 1) { Array.new(AVG + 1, INF) }
  (AVG + 1).times do |j|
    (AVG + 1).times do |k|
      case a
      when 1
        ep[j + b][k] = [ep[j + b][k], dp[j][k]].min if j + b <= AVG
        ep[j][k + b] = [ep[j][k + b], dp[j][k] + 1].min if k + b <= AVG
        ep[j][k] = [ep[j][k], dp[j][k] + 1].min
      when 2
        ep[j][k + b] = [ep[j][k + b], dp[j][k]].min if k + b <= AVG
        ep[j + b][k] = [ep[j + b][k], dp[j][k] + 1].min if j + b <= AVG
        ep[j][k] = [ep[j][k], dp[j][k] + 1].min
      else
        ep[j + b][k] = [ep[j + b][k], dp[j][k] + 1].min if j + b <= AVG
        ep[j][k + b] = [ep[j][k + b], dp[j][k] + 1].min if k + b <= AVG
        ep[j][k] = [ep[j][k], dp[j][k]].min
      end
    end
  end
  dp = ep.map { _1.dup }
end

puts dp[AVG][AVG] >= INF ? -1 : dp[AVG][AVG]
