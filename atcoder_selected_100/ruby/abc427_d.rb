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

  # dp[i] = iの位置に置いて手番が勝つ場合true
  # 後ろから考えると最後の手番はAlice
  dp = Array.new(n) { ss[_1] == "A" }
  (2 * k).times do |i|
    ep = [false] * n
    dp.each_with_index do |bool, to|
      # bool = false の場所に置けるなら手番の勝ち
      next if bool
      rev_edges[to].each do |from|
        ep[from] = true
      end
    end
    dp = ep
  end
  # 最初の手番はAlice
  puts dp[0] ? "Alice" : "Bob"
end
