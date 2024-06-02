# -
# ABC356/C
# ビット全探索

N, M, K = gets.split.map(&:to_i)
CAR = []
M.times do
  car = gets.chomp.split
  c = car[0].to_i
  a = car[1, c].reduce(0) {|acc, i| acc | 1 << i.to_i - 1 }
  r = car[-1]
  CAR << [c, a, r]
end

ans = (1 << N).times.count do |bit|
  # [0, 1, 2].count { bit[_1] == 1 } より (bit & 7).to_s(2).count("1")の方が圧倒的に速い
  CAR.all? { |c, a, r| ((bit & a).to_s(2).count("1") >=K) ^ (r != "o")  }
end

puts ans
