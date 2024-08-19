# -
# ABC213/D
# 深さ優先探索
# 木のオイラーツアー(Euler Tour)

N = gets.to_i
G = Array.new(N + 1) { [] }
(N - 1).times do
  a, b = gets.split.map(&:to_i)
  G[a] << b
  G[b] << a
end
G.each(&:sort!)

ANS = []

def dfs(cur = 1, pre = -1)
  ANS << cur
  G[cur].each do |nxt|
    next if nxt == pre
    dfs(nxt, cur)
    ANS << cur
  end
end

dfs
puts ANS.join(" ")
