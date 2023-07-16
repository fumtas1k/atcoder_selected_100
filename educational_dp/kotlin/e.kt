// e

fun main() {
  val (N, W) = readLine()!!.split(" ").map(String::toInt)
  val WV = MutableList(N) {readLine()!!.split(" ").map(String::toInt) }

  val V_MAX = 1_000 * N

  val dp = MutableList(V_MAX + 1) { W + 1L }
  dp[0] = 0L

  WV.forEach { (w, v) ->
    (V_MAX downTo v).forEach { i ->
      dp[i] = Math.min(dp[i], dp[i - v] + w)
    }
  }

  val vMax = (0 .. V_MAX).filter { dp[it] <= W }.max()
  println(vMax)
}
