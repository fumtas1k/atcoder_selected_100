/**
 * -
 * DPL-1/G
 * 動的計画法:ナップサックDP
 * 個数制限付きナップサックDP
 */
fun main() {
  val (N, W) = readln().split(" ").map(String::toInt)
  val VW = mutableListOf<Pair<Int, Int>>()
  repeat(N) {
    var (v, w, m) = readln().split(" ").map(String::toInt)
    var k = 1
    while (m > 0) {
      VW.add(v * k to w * k)
      m -= k
      k = minOf(k * 2, m)
    }
  }
  val dp = LongArray(W + 1) { - 1_000_000_000L }
  dp[0] = 0
  for ((v, w) in VW) {
    for (j in W downTo w) {
      dp[j] = maxOf(dp[j], dp[j - w] + v)
    }
  }
  println(dp.maxOrNull())
}
