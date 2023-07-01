# 70
# NTL-1/B
# べき乗計算

module AddPowerToInteger
  refine Integer do
    def power(n, mod)
      ans = 1
      exp = self
      n.bit_length.times do |i|
        ans = (ans * exp) % mod if n[i] == 1
        exp = (exp * exp) % mod
      end
      ans
    end
  end
end
using AddPowerToInteger

MOD = 10 ** 9 + 7
M, N = gets.split.map(&:to_i)

# puts M.pow(N, MOD)
puts M.power(N, MOD)
