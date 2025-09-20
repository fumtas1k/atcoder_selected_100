# -
# ABC424/D
# 全探索:ビット全探索
# ポップカウント事前計算

BLACK, WHITE = "#.".bytes
INF = 1 << 60
MAX = 1 << 7
pop_count = Array.new(MAX, 0)
MAX.times do |bit|
  pop_count[bit] = pop_count[bit >> 1] + bit[0]
end

ans = []
gets.to_i.times do
  h, w = gets.split.map(&:to_i)
  k = 1 << w
  grid = []
  h.times do
    grid << gets.bytes
  end

  # 隣接する行の状態間で許可される遷移を事前計算
  # allow[i][j] = i行目の状態がi、(i+1)行目の状態がjのとき、
  # 2×2の黒マス領域が形成されないかをチェック
  allow = Array.new(k) { Array.new(k, true) }

  k.times do |i|
    k.times do |j|
      (w - 1).times do |c|
        # 連続する2列で、上下両方の行で黒マス(1)が並んでいる場合
        # これは2×2の黒マス領域を形成するため禁止
        if ((i >> c) & 3) == 3 && ((j >> c) & 3) == 3
          allow[i][j] = false
          break
        end
      end
    end
  end

  # dp[j] = 現在の行で状態jを実現するのに必要な最小塗り替え回数
  dp = Array.new(k, INF)
  dp[0] = 0

  h.times do |r|
    # 現在の行の初期状態（黒マスの位置）をビットマスクで表現
    state = 0
    w.times do |c|
      state += (1 << c) if grid[r][c] == BLACK
    end

    ep = Array.new(k, INF)
    k.times do |bit|
      # 状態bitが実現可能かチェック
      # (bit | state) == state は、bitの1ビットがstateに含まれることを意味
      # つまり、黒マスを白に塗り替えることはできるが、白マスを黒にはできない
      next unless (bit | state) == state
      k.times do |prev_bit|
        # 前の行の状態prev_bitから現在の行の状態bitへの遷移が許可されているか
        next unless allow[prev_bit][bit]
        # 黒マスを白に塗り替える個数を計算
        # bit ^ state は、stateからbitに変更するために塗り替えが必要な位置
        paint_count = pop_count[bit ^ state]
        ep[bit] = [ep[bit], dp[prev_bit] + paint_count].min
      end
    end
    dp = ep
  end
  ans << dp.min
end

puts ans
