-- example reporting script which demonstrates a custom
-- done() function that prints latency percentiles as CSV

done = function(summary, latency, requests)
    io.write("------------------------------\n")
    for _, p in pairs({ 50, 90, 99, 99.999 }) do
        n = latency:percentile(p)
        io.write(string.format("latency %g%%: %.2f ms\n", p, n / 1000))
    end
    io.write(string.format("min: %.2f ms\n", latency.min / 1000))
    io.write(string.format("max: %.2f ms\n", latency.max / 1000))
    io.write(string.format("mean: %.2f ms\n", latency.mean / 1000))
end
