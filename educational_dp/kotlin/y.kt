// Y

 /**
 * 順列・組み合わせ
 * @property size サイズ
 * @property mod 除数
 */
class PermComb(
  private val size: Int,
  private val mod: Int
) {
  // 階乗
  private val fact = LongArray(size + 1) { 1L }
  // 階乗の逆数
  private val invFact = LongArray(size + 1) { 1L }

  init { prepare() }

  /**
   * 順列
   *
   * @param n 位数
   * @param r 選ぶ個数
   * @return 場合の数
   */
  fun perm(n: Int, r: Int): Long {
    if (n < 0 || r < 0 || n < r) return 0L
    return fact[n] * invFact[r] % mod
  }

  /**
   * 組み合わせ
   *
   * @param n 位数
   * @param r 選ぶ個数
   * @return 場合の数
   */
  fun comb(n: Int, r: Int): Long {
    if (n < 0 || r < 0 || n < r) return 0L
    return perm(n, r) * invFact[n - r] % mod
  }

  /**
   * 準備
   */
  private fun prepare() {
    (2 .. size).forEach {
      fact[it] = fact[it - 1] * it % mod
      invFact[it] = invFact[it - 1] * pow(it, mod - 2) % mod
    }
  }

  /**
   * 冪剰余
   *
   * @param x 底
   * @param n 指数
   * @return 冪剰余
   */
  private fun pow(x: Int, n: Int): Long {
    var base = x.toLong()
    var exp = n
    var ans = 1L
    while (exp > 0) {
      if (exp.and(1) == 1) ans = ans * base % mod
      exp /= 2
      base = base * base % mod
    }
    return ans
  }
}

fun main() {
  val M = 1_000_000_007
  val MAX = 100_000 * 2 + 1
  val (H, W, N) = readLine()!!.split(" ").map(String::toInt)
  val walls = MutableList(N) { readLine()!!.split(" ").map(String::toInt).map(Int::dec) }
  walls.add(listOf(H - 1, W - 1))
  walls.sortWith(compareBy({ it[0] + it[1] }))

  val permComb = PermComb(MAX, M)
  val dp = mutableListOf<Long>()

  walls.forEachIndexed { i, (r, c) ->
    dp.add(permComb.comb(r + c, c))

    repeat(i) { j ->
      val r1 = r - walls[j][0]
      val c1 = c - walls[j][1]
      if (r1 < 0 || c1 < 0) return@repeat
      dp[i] = (dp[i] - dp[j] * permComb.comb(r1 + c1, c1) % M + M) % M
    }
  }

  println(dp.last())
}
