/**
 * -
 * DPL-1/I
 * 動的計画法:ナップサックDP
 * 個数制限付きナップサックDP
 * 貪欲法
 * スライド最小値
 */
 fun main() {
  val (N, W) = readLine()!!.split(" ").map(String::toInt)
  val VWM = List(N) { readLine()!!.split(" ").map(String::toInt) }
  val maxV = VWM.maxOf { it[0] }
  val totalV = VWM.sumOf { (v, _, m) -> v * minOf(m, maxV) }

  val dp = IntArray(totalV + 1) { W + 1 }
  dp[0] = 0

  VWM.forEach { (v, w, m) ->
    val limit = minOf(m, maxV)
    repeat(v) { remainder ->
      val deque = ArrayDeque<Pair<Int, Int>>()
      var j = 0
      while (j * v + remainder <= totalV && j * w <= W) {
        val value = j * v + remainder
        val reducedW = dp[value] - j * w
        while (deque.isNotEmpty() && deque.last().second > reducedW) deque.removeLast()
        while (deque.isNotEmpty() && deque.first().first < j - limit) deque.removeFirst()
        deque.addLast(j to reducedW)
        dp[value] = minOf(dp[value], deque.first().second + j * w)
        j++
      }
    }
  }

  val remainingVwm = VWM.map { (v, w, m) -> Triple(v, w, maxOf(m - maxV, 0)) }
    .filter { it.third > 0 }
    .sortedBy { (v, w, _) -> w.toDouble() / v }

  var max_value = 0
  dp.forEachIndexed { value, weight ->
    if (weight > W) return@forEachIndexed
    var total_value = value
    var remainingW = W - weight
    remainingVwm.forEach { (v, w, m) ->
      val count = minOf(m, remainingW / w)
      total_value += count * v
      remainingW -= count * w
    }
    max_value = maxOf(max_value, total_value)
  }
  println(max_value)
}
