# E

# 重さの上限が10の6乗を超えており、価値の上限が10の6乗以下なので通常とは逆のやり方をする
V_MAX = 10 ** 3 * 10 ** 2
N, W = gets.split.map(&:to_i)

# indexが重さ、値が価値
dp = [Float::INFINITY] * (V_MAX + 1)
dp[0] = 0

N.times do |i|
  w, v = gets.split.map(&:to_i)
  (V_MAX).downto(v) do |j|
    # 同じ価値なら重さの合計が小さい方がより価値を高められるため重さを更新
    dp[j] = [dp[j], dp[j - v] + w].min
  end
end

# 重さがW以下で価値が最大のものを求める
puts (0 .. V_MAX).filter { dp[_1] <= W }.max
