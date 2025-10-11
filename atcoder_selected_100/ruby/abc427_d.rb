# -
# ABC427/D
# 動的計画法:その他
# ゲーム必勝法
# 後ろから考える

T = gets.to_i.times do
  n, m, k = gets.split.map(&:to_i)
  ss = gets.chomp.chars
  rev_edges = Array.new(n) { [] }
  m.times do
    u, v = gets.split.map(&:to_i).map(&:pred)
    rev_edges[v] << u
  end

  # dp[i] = Aliceが勝つ場合をtrue, Bobが勝つ場合をfalseとする
  # 後ろから考える
  dp = Array.new(n) { ss[_1] == "A" }
  (2 * k - 1).downto(0) do |i|
    # 偶数がAliceのターン, 奇数がBobのターン
    # そのターンの人が負ける値を初期値としておく
    ep = Array.new(n, i.odd?)
    dp.each_with_index do |bool, to|
      next if bool == i.odd?
      rev_edges[to].each do |from|
        ep[from] = bool
      end
    end
    dp = ep
  end
  puts dp[0] ? "Alice" : "Bob"
end
