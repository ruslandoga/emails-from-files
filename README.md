```console
$ MIX_ENV=bench mix run bench/render.exs
Operating System: macOS
CPU Information: Apple M1
Number of Available Cores: 8
Available memory: 8 GB
Elixir 1.14.0
Erlang 25.0.4

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 2 s
reduction time: 0 ns
parallel: 1
inputs: none specified
Estimated total run time: 45 s

Benchmarking cached ...
Benchmarking compiled ...
Benchmarking runtime ...
Benchmarking runtime_compiled ...
Benchmarking static ...

Name                       ips        average  deviation         median         99th %
static                  3.24 M      309.01 ns  ±7372.50%         250 ns        1167 ns
compiled                2.74 M      364.48 ns  ±6930.26%         292 ns        1125 ns
runtime_compiled        2.70 M      370.01 ns  ±7357.30%         292 ns        1125 ns
cached                0.0415 M    24115.23 ns    ±13.43%       22833 ns       33625 ns
runtime              0.00732 M   136636.53 ns    ±19.04%      131625 ns      195333 ns

Comparison:
static                  3.24 M
compiled                2.74 M - 1.18x slower +55.47 ns
runtime_compiled        2.70 M - 1.20x slower +61.01 ns
cached                0.0415 M - 78.04x slower +23806.23 ns
runtime              0.00732 M - 442.18x slower +136327.52 ns

Memory usage statistics:

Name                Memory usage
static                   1.42 KB
compiled                 1.66 KB - 1.16x memory usage +0.23 KB
runtime_compiled         1.66 KB - 1.16x memory usage +0.23 KB
cached                  66.43 KB - 46.72x memory usage +65.01 KB
runtime                 86.16 KB - 60.59x memory usage +84.73 KB

**All measurements for memory usage were the same**
```
