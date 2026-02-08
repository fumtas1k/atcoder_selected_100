# -
# ABC444/E
# 全探索:全列挙
# 尺取法
# 順序付き集合

# SortedMultiset / SortedSet for AtCoder (Ruby)
# Usage: copy-paste into your submission

# ソート済みマルチセット（重複を許可）
#
# 要素を複数のバケット（配列の配列）に分割して管理することで、
# 挿入・削除・検索の効率を保つデータ構造。
#
# @example 基本的な使用方法
#   ms = SortedMultiset.new([3, 1, 4, 1, 5])
#   ms.add(2)
#   ms.delete(1)
#   ms.min  # => 1
#   ms.max  # => 5
#   ms[2]   # => 3 (3番目の要素)
class SortedMultiset
  # バケットサイズの基準値
  BK = 1500

  # @return [Integer] マルチセット内の要素数
  attr_reader :size

  # 新しいSortedMultisetを初期化する
  #
  # @param a [Array, nil] 初期要素の配列（nilの場合は空のマルチセット）
  # @example
  #   ms = SortedMultiset.new([3, 1, 4, 1, 5])
  #   ms.size  # => 5
  def initialize(a = nil)
    @a = []      # バケットの配列
    @size = 0    # 要素の総数

    if a
      b = a.sort
      i = 0
      while i < b.size
        @a << b[i, BK]  # BK個ずつバケットに分割
        i += BK
      end
      @size = b.size
    end
  end

  # 要素を追加する
  #
  # @param v [Comparable] 追加する値
  # @return [SortedMultiset] self
  # @note 時間計算量: O(√N) 平均
  # @example
  #   ms = SortedMultiset.new
  #   ms.add(5)
  #   ms.add(3)
  #   ms.to_a  # => [3, 5]
  def add(v)
    if @a.empty?
      @a = [[v]]
      @size = 1
      return self
    end

    # 適切なバケットを二分探索で見つける
    lo, hi = 0, @a.size - 1
    while lo < hi
      m = (lo + hi) >> 1
      @a[m][-1] < v ? lo = m + 1 : hi = m
    end

    # バケット内の挿入位置を二分探索
    b = @a[lo]
    lo2, hi2 = 0, b.size
    while lo2 < hi2
      m = (lo2 + hi2) >> 1
      b[m] < v ? lo2 = m + 1 : hi2 = m
    end

    b.insert(lo2, v)
    @size += 1

    # バケットが大きくなりすぎたら分割
    if b.size > BK << 1
      mid = b.size >> 1
      @a.insert(lo + 1, b.slice!(mid..))
    end

    self
  end
  alias << add

  # 要素を1つ削除する
  #
  # @param v [Comparable] 削除する値
  # @return [Boolean] 削除に成功したらtrue、要素が存在しなければfalse
  # @note 時間計算量: O(√N) 平均
  # @example
  #   ms = SortedMultiset.new([1, 2, 2, 3])
  #   ms.delete(2)  # => true
  #   ms.to_a       # => [1, 2, 3]
  #   ms.delete(5)  # => false
  def delete(v)
    return false if @a.empty?

    # 適切なバケットを二分探索
    lo, hi = 0, @a.size - 1
    while lo < hi
      m = (lo + hi) >> 1
      @a[m][-1] < v ? lo = m + 1 : hi = m
    end

    # バケット内で削除位置を二分探索
    b = @a[lo]
    lo2, hi2 = 0, b.size
    while lo2 < hi2
      m = (lo2 + hi2) >> 1
      b[m] < v ? lo2 = m + 1 : hi2 = m
    end

    return false if lo2 >= b.size || b[lo2] != v

    b.delete_at(lo2)
    @size -= 1
    @a.delete_at(lo) if b.empty?  # 空のバケットを削除
    true
  end

  # 指定した値をすべて削除する
  #
  # @param v [Comparable] 削除する値
  # @return [Integer] 削除した要素の個数
  # @example
  #   ms = SortedMultiset.new([1, 2, 2, 2, 3])
  #   ms.delete_all(2)  # => 3
  #   ms.to_a           # => [1, 3]
  def delete_all(v)
    c = 0
    c += 1 while delete(v)
    c
  end

  # 要素が含まれているかチェックする
  #
  # @param v [Comparable] 検索する値
  # @return [Boolean] 要素が存在すればtrue
  # @note 時間計算量: O(log N)
  # @example
  #   ms = SortedMultiset.new([1, 3, 5])
  #   ms.include?(3)  # => true
  #   ms.include?(4)  # => false
  def include?(v)
    return false if @a.empty?

    lo, hi = 0, @a.size - 1
    while lo < hi
      m = (lo + hi) >> 1
      @a[m][-1] < v ? lo = m + 1 : hi = m
    end

    b = @a[lo]
    lo2, hi2 = 0, b.size
    while lo2 < hi2
      m = (lo2 + hi2) >> 1
      b[m] < v ? lo2 = m + 1 : hi2 = m
    end

    lo2 < b.size && b[lo2] == v
  end
  alias member? include?

  # v 以上の最小値を返す（下限）
  #
  # @param v [Comparable] 基準となる値
  # @return [Comparable, nil] v以上の最小値、存在しない場合はnil
  # @note 時間計算量: O(log N)
  # @example
  #   ms = SortedMultiset.new([1, 3, 5, 7])
  #   ms.lower_bound(4)  # => 5
  #   ms.lower_bound(5)  # => 5
  #   ms.lower_bound(8)  # => nil
  def lower_bound(v)
    return nil if @a.empty?

    lo, hi = 0, @a.size - 1
    while lo < hi
      m = (lo + hi) >> 1
      @a[m][-1] < v ? lo = m + 1 : hi = m
    end

    b = @a[lo]
    return nil if b[-1] < v

    lo2, hi2 = 0, b.size
    while lo2 < hi2
      m = (lo2 + hi2) >> 1
      b[m] < v ? lo2 = m + 1 : hi2 = m
    end

    b[lo2]
  end

  # v より大きい最小値を返す（上限）
  #
  # @param v [Comparable] 基準となる値
  # @return [Comparable, nil] vより大きい最小値、存在しない場合はnil
  # @note 時間計算量: O(log N)
  # @example
  #   ms = SortedMultiset.new([1, 3, 5, 7])
  #   ms.upper_bound(4)  # => 5
  #   ms.upper_bound(5)  # => 7
  #   ms.upper_bound(7)  # => nil
  def upper_bound(v)
    return nil if @a.empty?

    lo, hi = 0, @a.size - 1
    while lo < hi
      m = (lo + hi) >> 1
      @a[m][-1] <= v ? lo = m + 1 : hi = m
    end

    b = @a[lo]
    return nil if b[-1] <= v

    lo2, hi2 = 0, b.size
    while lo2 < hi2
      m = (lo2 + hi2) >> 1
      b[m] <= v ? lo2 = m + 1 : hi2 = m
    end

    b[lo2]
  end

  # v 以下の最大値を返す（逆下限）
  #
  # @param v [Comparable] 基準となる値
  # @return [Comparable, nil] v以下の最大値、存在しない場合はnil
  # @example
  #   ms = SortedMultiset.new([1, 3, 5, 7])
  #   ms.reverse_lower_bound(4)  # => 3
  #   ms.reverse_lower_bound(5)  # => 5
  #   ms.reverse_lower_bound(0)  # => nil
  def reverse_lower_bound(v)
    @a.empty? ? nil : ((c = count_le(v)) > 0 ? kth(c - 1) : nil)
  end

  # v 未満の最大値を返す（前の要素）
  #
  # @param v [Comparable] 基準となる値
  # @return [Comparable, nil] v未満の最大値、存在しない場合はnil
  # @example
  #   ms = SortedMultiset.new([1, 3, 5, 7])
  #   ms.prev(5)  # => 3
  #   ms.prev(4)  # => 3
  #   ms.prev(1)  # => nil
  def prev(v)
    @a.empty? ? nil : ((c = count_less(v)) > 0 ? kth(c - 1) : nil)
  end
  alias next_val upper_bound

  # k番目の要素を返す（0-indexed）
  #
  # @param k [Integer] インデックス（0始まり）
  # @return [Comparable, nil] k番目の要素、範囲外の場合はnil
  # @note 時間計算量: O(√N)
  # @example
  #   ms = SortedMultiset.new([10, 20, 30, 40])
  #   ms.kth(0)   # => 10
  #   ms.kth(2)   # => 30
  #   ms[2]       # => 30 (エイリアス)
  #   ms.kth(10)  # => nil
  def kth(k)
    return nil if k < 0 || k >= @size

    @a.each do |b|
      s = b.size
      return b[k] if k < s
      k -= s
    end
    nil
  end
  alias [] kth

  # v より小さい要素の数を返す
  #
  # @param v [Comparable] 基準となる値
  # @return [Integer] v未満の要素数
  # @note 時間計算量: O(√N)
  # @example
  #   ms = SortedMultiset.new([1, 3, 3, 5, 7])
  #   ms.count_less(3)  # => 1
  #   ms.count_less(4)  # => 3
  def count_less(v)
    c = 0
    @a.each do |b|
      if b[-1] < v
        c += b.size
      else
        lo, hi = 0, b.size
        while lo < hi
          m = (lo + hi) >> 1
          b[m] < v ? lo = m + 1 : hi = m
        end
        return c + lo
      end
    end
    c
  end

  # v 以下の要素の数を返す
  #
  # @param v [Comparable] 基準となる値
  # @return [Integer] v以下の要素数
  # @note 時間計算量: O(√N)
  # @example
  #   ms = SortedMultiset.new([1, 3, 3, 5, 7])
  #   ms.count_le(3)  # => 3
  #   ms.count_le(4)  # => 3
  def count_le(v)
    c = 0
    @a.each do |b|
      if b[-1] <= v
        c += b.size
      else
        lo, hi = 0, b.size
        while lo < hi
          m = (lo + hi) >> 1
          b[m] <= v ? lo = m + 1 : hi = m
        end
        return c + lo
      end
    end
    c
  end

  # 範囲 [l, h] 内の要素数を返す
  #
  # @param l [Comparable] 範囲の下限
  # @param h [Comparable] 範囲の上限
  # @return [Integer] 範囲内の要素数
  # @example
  #   ms = SortedMultiset.new([1, 3, 5, 7, 9])
  #   ms.count_range(3, 7)  # => 3 (3, 5, 7)
  def count_range(l, h)
    l > h ? 0 : count_le(h) - count_less(l)
  end

  # 値 v の個数を返す
  #
  # @param v [Comparable] カウントする値
  # @return [Integer] vの個数
  # @example
  #   ms = SortedMultiset.new([1, 2, 2, 2, 3])
  #   ms.count(2)  # => 3
  #   ms.count(5)  # => 0
  def count(v)
    count_range(v, v)
  end

  # 値 v のインデックスを返す
  #
  # @param v [Comparable] 検索する値
  # @return [Integer, nil] vの最初のインデックス、存在しない場合はnil
  # @example
  #   ms = SortedMultiset.new([1, 3, 3, 5])
  #   ms.index(3)  # => 1
  #   ms.index(4)  # => nil
  def index(v)
    p = count_less(v)
    p < @size && kth(p) == v ? p : nil
  end

  # 最小値を返す
  #
  # @return [Comparable, nil] 最小値、空の場合はnil
  # @note 時間計算量: O(1)
  # @example
  #   ms = SortedMultiset.new([3, 1, 4])
  #   ms.min  # => 1
  def min
    @a.empty? ? nil : @a[0][0]
  end

  # 最大値を返す
  #
  # @return [Comparable, nil] 最大値、空の場合はnil
  # @note 時間計算量: O(1)
  # @example
  #   ms = SortedMultiset.new([3, 1, 4])
  #   ms.max  # => 4
  def max
    @a.empty? ? nil : @a[-1][-1]
  end

  # 最小値を削除して返す
  #
  # @return [Comparable, nil] 削除した最小値、空の場合はnil
  # @note 時間計算量: O(1) 償却
  # @example
  #   ms = SortedMultiset.new([3, 1, 4])
  #   ms.shift  # => 1
  #   ms.to_a   # => [3, 4]
  def shift
    return nil if @a.empty?
    v = @a[0].shift
    @size -= 1
    @a.shift if @a[0].empty?
    v
  end

  # 最大値を削除して返す
  #
  # @return [Comparable, nil] 削除した最大値、空の場合はnil
  # @note 時間計算量: O(1) 償却
  # @example
  #   ms = SortedMultiset.new([3, 1, 4])
  #   ms.pop   # => 4
  #   ms.to_a  # => [1, 3]
  def pop
    return nil if @a.empty?
    v = @a[-1].pop
    @size -= 1
    @a.pop if @a[-1].empty?
    v
  end

  # 空かどうかを判定する
  #
  # @return [Boolean] 空ならtrue
  # @example
  #   ms = SortedMultiset.new
  #   ms.empty?  # => true
  #   ms.add(1)
  #   ms.empty?  # => false
  def empty?
    @size == 0
  end

  # 各要素に対してブロックを実行する
  #
  # @yield [v] 各要素
  # @return [Enumerator, self] ブロックなしの場合はEnumerator
  # @example
  #   ms = SortedMultiset.new([3, 1, 4])
  #   ms.each { |v| puts v }  # => 1, 3, 4 の順に出力
  def each(&bl)
    return enum_for(:each) unless bl
    @a.each { |b| b.each(&bl) }
  end

  # 各要素に対して逆順でブロックを実行する
  #
  # @yield [v] 各要素（逆順）
  # @return [Enumerator, self] ブロックなしの場合はEnumerator
  # @example
  #   ms = SortedMultiset.new([3, 1, 4])
  #   ms.reverse_each { |v| puts v }  # => 4, 3, 1 の順に出力
  def reverse_each(&bl)
    return enum_for(:reverse_each) unless bl
    @a.reverse_each { |b| b.reverse_each(&bl) }
  end

  # 配列に変換する
  #
  # @return [Array] ソート済みの配列
  # @example
  #   ms = SortedMultiset.new([3, 1, 4, 1])
  #   ms.to_a  # => [1, 1, 3, 4]
  def to_a
    @a.flatten
  end
end

# ソート済みセット（重複を許可しない）
#
# SortedMultisetをラップして重複を排除したデータ構造。
#
# @example 基本的な使用方法
#   ss = SortedSet.new([3, 1, 4, 1, 5])
#   ss.size  # => 4 (重複が排除される)
#   ss.add(1)  # => false (既に存在)
#   ss.add(2)  # => true
#   ss.to_a  # => [1, 2, 3, 4, 5]
class SortedSet
  # @return [Integer] セット内の要素数
  attr_reader :size

  # 新しいSortedSetを初期化する
  #
  # @param a [Array, nil] 初期要素の配列（重複は自動的に削除される）
  # @example
  #   ss = SortedSet.new([3, 1, 4, 1, 5])
  #   ss.size  # => 4
  def initialize(a = nil)
    @ms = SortedMultiset.new
    @size = 0

    if a
      h = {}
      a.each do |v|
        next if h[v]
        h[v] = 1
        @ms.add(v)
      end
      @size = @ms.size
    end
  end

  # 要素を追加する（重複は追加しない）
  #
  # @param v [Comparable] 追加する値
  # @return [Boolean] 新しい要素を追加した場合true、既に存在する場合false
  # @example
  #   ss = SortedSet.new([1, 2, 3])
  #   ss.add(4)  # => true
  #   ss.add(2)  # => false
  def add(v)
    return false if @ms.include?(v)
    @ms.add(v)
    @size = @ms.size
    true
  end
  alias << add

  # 要素を削除する
  #
  # @param v [Comparable] 削除する値
  # @return [Boolean] 削除に成功したらtrue
  def delete(v)
    r = @ms.delete(v)
    @size = @ms.size if r
    r
  end

  # 要素が含まれているかチェックする
  #
  # @param v [Comparable] 検索する値
  # @return [Boolean] 要素が存在すればtrue
  def include?(v)
    @ms.include?(v)
  end
  alias member? include?

  # v 以上の最小値を返す
  #
  # @param v [Comparable] 基準となる値
  # @return [Comparable, nil] v以上の最小値
  def lower_bound(v)
    @ms.lower_bound(v)
  end

  # v より大きい最小値を返す
  #
  # @param v [Comparable] 基準となる値
  # @return [Comparable, nil] vより大きい最小値
  def upper_bound(v)
    @ms.upper_bound(v)
  end

  # v 以下の最大値を返す
  #
  # @param v [Comparable] 基準となる値
  # @return [Comparable, nil] v以下の最大値
  def reverse_lower_bound(v)
    @ms.reverse_lower_bound(v)
  end

  # v 未満の最大値を返す
  #
  # @param v [Comparable] 基準となる値
  # @return [Comparable, nil] v未満の最大値
  def prev(v)
    @ms.prev(v)
  end

  # v より大きい最小値を返す
  #
  # @param v [Comparable] 基準となる値
  # @return [Comparable, nil] vより大きい最小値
  def next_val(v)
    @ms.upper_bound(v)
  end

  # k番目の要素を返す（0-indexed）
  #
  # @param k [Integer] インデックス
  # @return [Comparable, nil] k番目の要素
  def kth(k)
    @ms.kth(k)
  end
  alias [] kth

  # v より小さい要素の数を返す
  #
  # @param v [Comparable] 基準となる値
  # @return [Integer] v未満の要素数
  def count_less(v)
    @ms.count_less(v)
  end

  # v 以下の要素の数を返す
  #
  # @param v [Comparable] 基準となる値
  # @return [Integer] v以下の要素数
  def count_le(v)
    @ms.count_le(v)
  end

  # 範囲 [l, h] 内の要素数を返す
  #
  # @param l [Comparable] 範囲の下限
  # @param h [Comparable] 範囲の上限
  # @return [Integer] 範囲内の要素数
  def count_range(l, h)
    @ms.count_range(l, h)
  end

  # 値 v のインデックスを返す
  #
  # @param v [Comparable] 検索する値
  # @return [Integer, nil] vのインデックス
  def index(v)
    @ms.index(v)
  end

  # 最小値を返す
  #
  # @return [Comparable, nil] 最小値
  def min
    @ms.min
  end

  # 最大値を返す
  #
  # @return [Comparable, nil] 最大値
  def max
    @ms.max
  end

  # 最小値を削除して返す
  #
  # @return [Comparable, nil] 削除した最小値
  def shift
    v = @ms.shift
    @size = @ms.size
    v
  end

  # 最大値を削除して返す
  #
  # @return [Comparable, nil] 削除した最大値
  def pop
    v = @ms.pop
    @size = @ms.size
    v
  end

  # 空かどうかを判定する
  #
  # @return [Boolean] 空ならtrue
  def empty?
    @ms.empty?
  end

  # 各要素に対してブロックを実行する
  #
  # @yield [v] 各要素
  # @return [Enumerator, self] ブロックなしの場合はEnumerator
  def each(&bl)
    @ms.each(&bl)
  end

  # 各要素に対して逆順でブロックを実行する
  #
  # @yield [v] 各要素（逆順）
  # @return [Enumerator, self] ブロックなしの場合はEnumerator
  def reverse_each(&bl)
    @ms.reverse_each(&bl)
  end

  # 配列に変換する
  #
  # @return [Array] ソート済みの配列
  def to_a
    @ms.to_a
  end
end

INF = 10**18

N, D = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

sorted_set = SortedSet.new
sorted_set << -INF
sorted_set << 2*INF

ans = 0
r = 0
N.times do |l|
  r = l if r < l
  while r < N
    ar = A[r]
    break if sorted_set.lower_bound(ar) - ar < D
    break if ar - sorted_set.prev(ar) < D
    sorted_set << ar
    r += 1
  end
  sorted_set.delete(A[l])
  ans += r - l
end

puts ans
