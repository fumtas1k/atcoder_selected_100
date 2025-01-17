# -
# ABC374/E
# 決め打ち二分探索
# 最小値の最大化

INF = 1 << 60
N, X = gets.split.map(&:to_i)
APBQ = Array.new(N) { gets.split.map(&:to_i) }

def calc_x(w)
  APBQ.sum do |a, p, b, q|
    # コスパが良い方を機械Siにする
    a, p, b, q = b, q, a, p if p / a.to_r > q / b.to_r

    # 機械SiをBi台 = 機械TiをAi台 = 処理能力AiBi個
    # コスト最小化する場合、 w <= Ai * Bi * x + Ai * y　+ Bi * z = Ai * (Bi * x + y) + Bi * z = Ai * j + Bi * k
    # Siをj台、Tiをk台購入すれば良い。
    # kはAi未満(TiをAi台以上購入するくらいなら、Siを購入した方が安い)
    a.times.reduce(INF) do |acc, k|
      # 切り上げるために a - 1 を足している
      j = [(w - b * k + (a - 1)) / a, 0].max
      [acc, p * j + q * k].min
    end
  end
end

# Ai, Biが100, Pi, Qiが1, X=10 ** 7の場合、最大個数は10 ** 9
puts (0 .. 10 ** 9 + 1).bsearch { calc_x(_1) > X } - 1
