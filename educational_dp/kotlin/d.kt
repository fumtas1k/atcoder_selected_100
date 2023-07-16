// D

fun main() {
  val (N, W) = readLine()!!.split(" ").map(String::toInt)
  val WV = List(N) { readLine()!!.split(" ").map(String::toInt) }
  val dp = MutableList(N + 1) { MutableList(W + 1) { Long.MIN_VALUE } }
  dp[0][0] = 0L

  WV.forEachIndexed { i, (w, v) ->
    (0 .. W).forEach { j ->
      dp[i + 1][j] = dp[i][j]
      if (j < w) return@forEach
      dp[i + 1][j] = Math.max(dp[i + 1][j], dp[i][j - w] + v)
    }
  }

  println(dp[N].max())
}
