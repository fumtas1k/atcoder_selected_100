# -
# ABC354/E
# bitDP
# 後ろから考える

N = gets.to_i
AB = Array.new(N) { gets.split.map(&:to_i) }

# dp[bit]: 場にカードがbitの状態である場合に先手が勝つか
# 場に0枚のカードの場合は先手は負けなのでfalse
dp = Array.new(1 << N) { false }

(1 << N).times do |bit|
  N.times do |i|
    next if bit[i].zero?
    break if dp[bit]
    (i + 1).upto(N - 1) do |j|
      next if bit[j].zero? || i == j
      # 先手が勝つのは、表か裏が同じ数字勝つ、その2枚のカードを取った場合の状態が負けのとき
      if (AB[i][0] == AB[j][0] || AB[i][1] == AB[j][1]) && !dp[bit ^ (1 << i) ^ (1 << j)]
        dp[bit] = true
        break
      end
    end
  end
end

puts dp[-1] ? "Takahashi" : "Aoki"
