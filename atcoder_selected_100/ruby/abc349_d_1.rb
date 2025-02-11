# -
# ABC349/D
# その他
# セグメント木の考え方
# 深さ優先探索

L, R = gets.split.map(&:to_i)
MAX = R.bit_length

ans = []
dfs = ->(l, r) do
  return if R <= l || r <= L
  return ans << [l, r].join(" ") if L <= l && r <= R
  dfs[l, (r + l) / 2]
  dfs[(r + l) / 2, r]
end
dfs[0, 1 << MAX]
puts ans.size
puts ans
