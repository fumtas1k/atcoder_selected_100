# -
# ABC374/E
# 決め打ち二分探索
# 最小値の最大化

N, X = gets.split.map(&:to_i)
APBQ = Array.new(N) { gets.split.map(&:to_i) }

def calc_x(w)
  APBQ.sum do |a, p, b, q|
    # コスパが良い方を機械Siにする
    # 機械SiをBi台 = 機械TiをAi台 = 処理能力AiBi個
    # コスト最小化する場合、 w = AiBi * x + Ai * y　+ Bi * z = Ai * (Bi * x + y) + Bi * z
    # Siを(Bi * x + y)台、Tiをz台購入すれば良い。
    # zはAi未満(TiをAi台以上購入するくらいなら、Siを購入した方が安い)
    if p / a.to_r > q / b.to_r
      a, b, p, q = b, a, q, p
    end
    res = Float::INFINITY
    a.times do |j|
      i = [(w - b * j + a - 1) / a, 0].max
      res = [res, p * i + q * j].min
    end
    res
  end
end

# Ai, Biが100, Pi, Qiが1, X=10 ** 7の場合、最大個数は10 ** 9
puts (0 .. 10 ** 9 + 1).bsearch { calc_x(_1) > X } - 1
