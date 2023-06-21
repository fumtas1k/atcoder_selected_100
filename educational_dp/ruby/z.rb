# Z
# 理解を深める参考サイト: https://satanic0258.hatenablog.com/entry/2016/08/16/181331

class CHT
  attr_accessor :lines

  Line = Struct.new(:a, :b) {
    def get_y(x)
      a * x + b
    end

    def need?(l1, l2)
      # 傾きがl1 < self < l2 で selfとl2の交点のx < selfとl1の交点のx の場合必要
      # 最小値を取る直線は左から順に傾きが減少する
      (a - l1.a) * (l2.b - b) < (l2.a - a) * (b - l1.b)
    end
  }

  def initialize
    @lines = []
  end

  def add(a, b)
    l = Line.new(a, b)
    # linesが2より大きくないと比較できない。
    # 終端が必要なら抜くのをやめる。
    until lines.size < 2 || lines[-1].need?(lines[-2], l)
      lines.pop
    end
    lines << l
  end

  def miny(x)
    pp lines.map { _1.a }
    left = -1
    right = lines.size - 1
    while right - left > 1
      m = (right + left) / 2
      if lines[m].get_y(x) < lines[m + 1].get_y(x)
        # mの方がyは小さい
        right = m
      else
        # mの方がyは大きい
        left = m
      end
    end
    # 小さいyを知りたいのでrightを取る
    lines[right].get_y(x)
  end

end

N, C = gets.split.map(&:to_i)
# Hは単調増加
H = gets.split.map(&:to_i)
dp = [0] * N
cht = CHT.new

1.upto(N - 1) do |i|
  # dp[i] = [dp[i], dp[j] + (H[i] - H[j]) ** 2 + C].min　を式展開
  # H[i] ** 2 + C + (- 2 * H[i]H[j] + H[j] ** 2)(i - 1までの最小)
  # a = - 2 * H[j], b = H[j] ** 2
  # Hは単調増加なので、追加するaは常に最小となる
  cht.add(-2 * H[i - 1], dp[i - 1] + H[i - 1] ** 2)
  dp[i] = H[i] ** 2 + C + cht.miny(H[i])
end

puts dp[-1]
