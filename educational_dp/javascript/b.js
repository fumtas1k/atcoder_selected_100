// B

const input = require("fs").readFileSync("/dev/stdin", "utf-8").split("\n");
const [N, K] = input[0].split(" ").map(Number);
const H = input[1].split(" ").map(Number);
const dp = new Array(N).fill(Number.MAX_VALUE);
dp[0] = 0;

for (let i = 0; i < N; i++) {
  for (let j = 1; j <= K; j++) {
    if (i + j >= N) continue;
    dp[i + j] = Math.min(dp[i + j], dp[i] + Math.abs(H[i + j] - H[i]));
  }
}

console.log(dp[N - 1]);
