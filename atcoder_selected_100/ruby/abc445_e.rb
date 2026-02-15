# -
# ABC445/E
# 素因数分解
# フェルマーの小定理

MOD = 998244353

# 素数列挙と素因数分解を効率的に行うクラス
class Prime
  # @return [Array<Integer>] エラトステネスの篩で生成された素数のリスト
  attr_reader :primes

  # @return [Hash{Integer => Array<Array(Integer, Integer)>}]
  #   素因数分解結果のキャッシュ。キーは数値、値は[素数, 指数]のペアの配列
  attr_reader :factors

  # Primeクラスの新しいインスタンスを初期化
  #
  # @param max [Integer] 素因数分解する可能性のある最大値
  # @example
  #   prime = Prime.new(10000000)
  #   prime.factorize(12) # => [[2, 2], [3, 1]]
  def initialize(max)
    @max = Integer.sqrt(max)
    @primes = []
    @factors = Hash.new
    get_primes
  end

  # 与えられた数を素因数分解する
  #
  # 結果はメモ化され、同じ数に対する再計算を避ける
  #
  # @param n [Integer] 素因数分解する正の整数
  # @return [Array<Array(Integer, Integer)>]
  #   [素数, 指数]のペアの配列。例: 12 => [[2, 2], [3, 1]] (12 = 2^2 × 3^1)
  # @example
  #   prime = Prime.new(1000)
  #   prime.factorize(60)  # => [[2, 2], [3, 1], [5, 1]]
  #   prime.factorize(100) # => [[2, 2], [5, 2]]
  def factorize(n)
    return @factors[n] if @factors[n]
    i = n
    res = []
    @primes.each do |d|
      break if d * d > i
      e = 0
      while i % d == 0
        i /= d
        e += 1
      end
      res << [d, e] unless e.zero?
    end
    res << [i, 1] if i > 1
    @factors[n] = res
  end

  private

  # エラトステネスの篩を使用して√maxまでの素数を生成
  #
  # @api private
  # @return [void]
  def get_primes
    is_prime = [true] * (@max + 1)
    is_prime[0] = is_prime[1] = false

    (2 .. @max).each do |i|
      next unless is_prime[i]
      @primes << i
      (2 * i).step(@max, i) { is_prime[_1] = false }
      @factors[i] = [[i, 1]]
    end
  end
end

T = gets.to_i
prime = Prime.new(10 ** 7)
T.times do
  gets
  as = gets.split.map(&:to_i)

  e1 = Hash.new(0)
  e2 = Hash.new(0)

  # e_1(p), e_2(p) を計算
  as.each do |a|
    prime.factorize(a).each do |p, e|
      if e > e1[p]
        e2[p] = e1[p]
        e1[p] = e
      elsif e > e2[p]
        e2[p] = e
      end
    end
  end

  lcm = 1
  e1.each do |p, e|
    lcm = lcm * p.pow(e, MOD) % MOD
  end

  results = []
  as.each do |a|
    ans = lcm

    prime.factorize(a).each do |p, e|
      if e == e1[p]
        # ans /= p^(e1[p] - e2[p])
        diff = e1[p] - e2[p]
        ans = ans * p.pow(diff, MOD).pow(MOD - 2, MOD) % MOD
      end
    end

    results << ans
  end

  puts results.join(' ')
end
