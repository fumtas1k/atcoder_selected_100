# 60
# GRL-1/C
# 最短経路問題:ワーシャルフロイド法

V, E = gets.split.map(&:to_i)
G = Array.new(V) { [Float::INFINITY] * V }
V.times { |i| G[i][i] = 0 }
E.times do
    s, t, d = gets.split.map(&:to_i)
    G[s][t] = d
end

V.times do |k|
    V.times do |i|
        V.times do |j|
            G[i][j] = [G[i][k] + G[k][j], G[i][j]].min
        end
    end
end

if V.times.any? { |i| G[i][i] < 0 }
    puts "NEGATIVE CYCLE"
else
    G.each { |row| puts row.map{ |i| i == Float::INFINITY ? "INF" : i }.join(" ") }
end
