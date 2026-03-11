# -
# AWC0023/E
# 動的計画法:ビットDP
# ビンパッキング問題

N, C = gets.split.map(&:to_i)
W = gets.split.map(&:to_i)

# dp[bit] = [集合 bit の荷物を運ぶための最小運搬回数, その最小運搬回数での、最後の運搬の積載量]
dp = Array.new(1 << N) { [N + 1, C + 1] }
dp[0] = [1, 0] # 初期状態: 運搬回数 1、積載量 0

(1 << N).times do |bit|
  trips, weight = dp[bit]

  W.each_with_index do |w, i|
    next if bit[i] == 1

    nxt_bit = bit | (1 << i)

    if weight + w <= C
      nxt_trips = trips
      nxt_w = weight + w
    else
      nxt_trips = trips + 1
      nxt_w = w
    end

    # より良い状態（運搬回数が少ない、もしくは同じ運搬回数で積載量が少ない）なら更新
    if ([nxt_trips, nxt_w] <=> dp[nxt_bit]) < 0
      dp[nxt_bit][0] = nxt_trips
      dp[nxt_bit][1] = nxt_w
    end
  end
end

puts dp[-1][0]
