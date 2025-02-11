# -
# ABC349/D
# その他
# セグメント木の考え方

L, R = gets.split.map(&:to_i)

ans = []
i = 0
l = L
r = R
while l < r
  if l[0] == 1
    ans << [l << i, (l + 1) << i]
    l += 1
  end
  if r[0] == 1
    ans << [(r - 1) << i, r << i]
    r -= 1
  end
  l >>= 1
  r >>= 1
  i += 1
end

ans.sort!
puts ans.size
puts ans.map { _1.join(" ") }
