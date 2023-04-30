N = gets.to_i
A, B = Array.new(N) { gets.split.map(&:to_i) }.transpose

s = A.sort[N / 2]
t = B.sort[N / 2]

puts A.sum { (_1 - s).abs } + B.sum { (_1 - t).abs } + A.zip(B).sum { _1.reduce(:-).abs }
