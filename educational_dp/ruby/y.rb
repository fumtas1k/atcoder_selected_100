# Y

class PermComb
  def initialize(size, mod)
    @mod = mod
    @size = size
    @fact = [1, 1]
    @inv_fact = [1, 1]
    prepare(size)
  end

  def perm(n, r)
    @fact[n] * @inv_fact[r] % @mod
  end

  def comb(n, r)
    perm(n, r) * @inv_fact[n - r] % @mod
  end

  private
  def prepare(n)
    return if n <= 1
    2.upto(n) do |i|
      @fact[i] = i * @fact[i - 1] % @mod
      @inv_fact[i] = i.pow(@mod - 2, @mod) * @inv_fact[i - 1] % @mod
    end
  end
end

M = 10 ** 9 + 7
H, W, N = gets.split.map(&:to_i)
# マンハッタン距離でソート. 順番に処理するのに必要
WALLS = Array.new(N) { gets.split.map(&:to_i).map(&:pred) }.sort_by { _1.reduce(:+) }
WALLS << [H - 1, W - 1]
dp = []
perm_comb = PermComb.new(H + W, M)

# 壁を1つも通らず壁まで辿り着く場合の数 = (壁を1つ以上通って壁にたどり着く場合の数)の余事象
# 壁の最後をゴールとしているので順番に求めていけばdpの最後が答え
WALLS.each_with_index do |(r, c), i|
  # 壁iまで辿り着く場合の数(壁を通る場合を含む)
  dp[i] = perm_comb.comb(r + c, r)
  i.times do |j|
    r0, c0 = WALLS[j]
    r1, c1 = r - r0, c - c0
    # 壁jから壁iに辿り着けないものを除く
    next if r1 < 0 || c1 < 0
    # 壁iにたどり着く場合の数 - 壁jを通って壁jにたどり着く場合の数
    dp[i] = (dp[i] - dp[j] * perm_comb.comb(r1 + c1, r1) + M) % M
  end
end

puts dp[-1]
