# -
# ABC374/E
# 決め打ち二分探索
# 最小値の最大化

N, X = gets.split.map(&:to_i)
APBQ = Array.new(N) { gets.split.map(&:to_i) }

def calc_x(w)
  APBQ.sum do |a, p, b, q|
    res = Float::INFINITY
    # 機械SiをBi台と機械TiをAi台は、共にAiBi個の処理能力なのでそれ以上の台数を購入するなら安い方で良い
    # つまり、どちらかはAiBi個以下の処理能力で良い
    (b + 1).times do |i|
      j = [(w - a * i + b - 1) / b, 0].max
      res = [res, p * i + q * j].min
    end
    (a + 1).times do |j|
      i = [(w - b * j + a - 1) / a, 0].max
      res = [res, p * i + q * j].min
    end
    res
  end
end

puts (0 .. 10 ** 9 + 1).bsearch { calc_x(_1) > X } - 1
