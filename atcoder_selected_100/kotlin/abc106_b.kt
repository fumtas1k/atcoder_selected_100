/** 2
 * ABC106/B
 * 全探索:全列挙
 */

 fun main() {
  val N = readLine()!!.toInt()
  val divisor = MutableList(N + 1) { 0 }

  (1 .. N step 2).forEach { i ->
    (i .. N step i).forEach { divisor[it]++ }
  }

  println((1 .. N step 2).count { divisor[it] == 8 })
}
