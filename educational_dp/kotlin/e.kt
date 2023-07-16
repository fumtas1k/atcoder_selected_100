// e

fun main() {
  val (N, W) = readLine()!!.split(" ").map(String::toInt)
  val WV = MutableList(N) {readLine()!!.split(" ").map(String::toInt) }

  val V_MAX = 1_000 * N

  val dp = MutableList(N + 1) { MutableList(V_MAX + 1) { W + 1L }}
  dp[0][0] = 0L

  WV.forEachIndexed { i, (w, v) ->
    (0 .. V_MAX).forEach { j ->
      dp[i + 1][j] = dp[i][j]
      if (j < v) return@forEach
      dp[i + 1][j] = Math.min(dp[i + 1][j], dp[i][j - v] + w)
    }
  }

  val vMax = (0 .. V_MAX).filter { dp[N][it] <= W }.max()
  println(vMax)
}
