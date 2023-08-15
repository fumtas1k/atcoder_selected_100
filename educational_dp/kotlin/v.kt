// V

fun solve() {
  val (N, M) = readLine()!!.split(" ").let { Pair(it[0].toInt(), it[1].toLong()) }
  val G = MutableList(N) { mutableListOf<Int>() }
  repeat(N - 1) {
    val (x, y) = readLine()!!.split(" ").map(String::toInt).map(Int::dec)
    G[x].add(y)
    G[y].add(x)
  }

  val dp = LongArray(N) { 0L }

  fun dfs1(pos: Int, pre: Int = -1): Long {
    if (dp[pos] != 0L) return dp[pos]
    dp[pos] = 1L
    G[pos].forEach {
      if (it == pre) return@forEach
      dp[pos] = dp[pos] * (dfs1(it, pos) + 1) % M
    }
    return dp[pos]
  }

  val ans = MutableList(N) { 0L }

  fun dfs2(pos: Int, pre: Int = -1) {
    ans[pos] = 1L
    G[pos].forEach {
      ans[pos] = ans[pos] * (dp[it] + 1) % M
      ans[pos] %= M
    }
    val n = G[pos].size
    val cProductL = MutableList(n) { 0L }
    val cProductR = MutableList(n) { 0L }
    G[pos].forEachIndexed { i, u ->
      cProductL[i] = dp[u] + 1
      cProductR[i] = dp[u] + 1
    }

    (1 .. n - 1).forEach {
      cProductL[it] = cProductL[it] * cProductL[it - 1] % M
      cProductR[n - it - 1] = cProductR[n - it - 1] * cProductR[n - it] % M
    }

    G[pos].forEachIndexed { i, u ->
      if (u == pre) return@forEachIndexed
      dp[pos] = 1L
      if (i != 0) dp[pos] = dp[pos] * cProductL[i - 1] % M
      if (i + 1 < n) dp[pos] = dp[pos] * cProductR[i + 1] % M
      dfs2(u, pos)
    }
  }

  dfs1(0)
  dfs2(0)

  ans.forEach(::println)
}

fun main() {
  Thread(null, ::solve, "solve", 1.shl(26)).start()
}
