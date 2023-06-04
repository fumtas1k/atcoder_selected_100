# 72
# ABC034/C
# 逆元

M = 1_000_000_007

W, H = gets.split.map(&:to_i)

def ncr(n, r)
  n.downto(n - r + 1).inject(1) { |acc, i| (acc * i) % M } *
  r.downto(1).inject(1) { |acc, i| (acc * i.pow(M - 2, M)) % M } % M
end

puts ncr(W + H - 2, W - 1)
