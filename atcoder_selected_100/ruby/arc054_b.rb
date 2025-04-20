# 23
# ARC054/B
# 二分探索
# 黄金分割探索

PHI = (Math.sqrt(5) + 1) / 2

P = gets.to_f

f = -> t do
  t + P / 2.pow(t / 1.5)
end

l = 0
r = P + 1
m1 = l + (r - l) / (1 + PHI)
m2 = r - (r - l) / (1 + PHI)
fm1 = f.call(m1)
fm2 = f.call(m2)

while r - l >= 1e-8 || (fm1 - fm2).abs >= 1e-8
  if fm1 < fm2
    r = m2
    m2 = m1
    fm2 = fm1
    m1 = l + (r - l) / (1 + PHI)
    fm1 = f.call(m1)
  else
    l = m1
    m1 = m2
    fm1 = fm2
    m2 = r - (r - l) / (1 + PHI)
    fm2 = f.call(m2)
  end
end

puts fm2
