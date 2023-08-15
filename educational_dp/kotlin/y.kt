// Y

class PermComb(
  private val size: Int,
  private val mod: Int
) {
  private val fact: LongArray
  private val invFact: LongArray

  init {
    fact = LongArray(size + 1) { 1L }
    invFact = LongArray(size + 1) { 1L }
    prepare()
  }

  fun perm(n: Int, r: Int): Long {
    if (n < 0 || r < 0) return 1L
    return fact[n] * invFact[r] % mod
  }

  fun comb(n: Int, r: Int): Long {
    if (n < 0 || r < 0) return 1L
    return perm(n, r) * invFact[n - r] % mod
  }

  private fun prepare() {
    (2 .. size).forEach {
      fact[it] = fact[it - 1] * it % mod
      invFact[it] = invFact[it - 1] * pow(it, mod - 2) % mod
    }
  }

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
