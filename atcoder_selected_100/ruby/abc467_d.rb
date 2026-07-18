# -
# ABC467/D
# 数学的問題
# 外積の平行判定
# 係数の標準化

def get_canonical(x1, y1, x2, y2)
  # 2 * (x2 - x1) * cx + 2 * (y2 - y1) * cy + x1^2 + y1^2 - (x2^2 + y2^2) == 0
  a = 2 * (x2 - x1)
  b = 2 * (y2 - y1)
  c = x1 ** 2 + y1 ** 2 - (x2 ** 2 + y2 ** 2)

  g = [a, b, c].filter { !it.zero? }.reduce { |acc, x| acc.gcd(x) }
  return [a, b, c] unless g
  a /= g
  b /= g
  c /= g
  ope = 1
  ope = -1 if a < 0 || (a.zero? && b < 0)
  [ope * a, ope * b, ope * c]
end

def judge(px, py, qx, qy, rx, ry, sx, sy)
  a1, b1, c1 = get_canonical(px, py, qx, qy)
  a2, b2, c2 = get_canonical(rx, ry, sx, sy)
  # 平行条件(外積)
  if a1 * b2 - a2 * b1 == 0
    return a1 == a2 && b1 == b2 && c1 == c2 
  end
  true
end

gets.to_i.times do
  px, py, qx, qy, rx, ry, sx, sy = gets.split.map(&:to_i)
  puts judge(px, py, qx, qy, rx, ry, sx, sy) ? "Yes" : "No"
end
