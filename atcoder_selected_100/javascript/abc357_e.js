// -
// ABC357/E
// 強連結成分分解
// 深さ優先探索

class SCC {
  constructor(size) {
    this.size = size;
    this.edges = [...Array(this.size)].map(() => []);
  }

  add_edge(from, to) {
    this.edges[from].push(to);
  }

  scc() {
    const [group_size, ids] = this.#scc_ids();
    const groups = [...Array(group_size)].map(() => []);
    ids.forEach((id, i) => groups[id].push(i));
    return groups;
  }

  #scc_ids() {
    let group_num = 0;
    let current_ord = 0;
    const visited = [];
    const ord = [];
    const low = [];
    const ids = [];

    const dfs = from => {
      if (ord[from]) return;
      ord[from] = current_ord;
      low[from] = current_ord++;
      visited.push(from);

      this.edges[from].forEach(to => {
        if (ord[to]) {
          low[from] = Math.min(low[from], ord[to]);
        } else {
          dfs(to);
          low[from] = Math.min(low[from], low[to]);
        }
      });

      if (ord[from] !== low[from]) return;
      while (visited.length !== 0) {
        const to = visited.pop();
        ord[to] = this.size;
        ids[to] = group_num;
        if (from == to) break;
      }
      group_num++;
    }

    for (let i = 0; i < this.size; i++) dfs(i);

    return [group_num, ids.map(i => group_num - 1 - i)];
  }
}

const input = require("fs").readFileSync("/dev/stdin", "utf8").split("\n");
const N = Number(input[0]);
const A = input[1].split(" ").map(a => Number(a) - 1);

const scc = new SCC(N);
A.forEach((a, i) => scc.add_edge(i, a));
const ans = new Array(N);

scc.scc().reverse().forEach(arr => {
  if (arr.length > 1 || arr[0] === A[arr[0]]) {
    arr.forEach(i => ans[i] = arr.length);
  } else {
    ans[arr[0]] = ans[A[arr[0]]] + 1;
  }
});

console.log(ans.reduce((acc, i) => acc + i, 0));
