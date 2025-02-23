# P

M = 10 ** 9 + 7
N = gets.to_i
G = Array.new(N) { [] }

(N - 1).times do
  x, y = gets.split.map(&:to_i).map(&:pred)
  G[x] << y
  G[y] << x
end

dfs = ->(pos = 0, pre = -1) do
  # res[i] := pos を根とする部分木において、pos の色が i である場合の数
  # i = 0: 白, j = 1: 黒
  res = [1, 1]
  G[pos].each do |to|
    next if to == pre
    w, b = dfs.(to, pos)
    res[0] = (w + b) * res[0] % M
    res[1] = w * res[1] % M
  end
  res
end

puts dfs.().sum % M
