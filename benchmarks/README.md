# Agent Data Benchmarks

This directory contains comprehensive benchmark tests for the `agent_data` class using Google Benchmark.

## Benchmarks Included

### 1. `BM_AddSingleAgent`
- **Purpose**: Measures the performance of adding a single agent to an empty `agent_data` container
- **Use Case**: Baseline performance for the add operation

### 2. `BM_AddMultipleAgents`
- **Purpose**: Measures performance of adding multiple agents sequentially
- **Range**: Tests with 10 to 10,000 agents
- **Insight**: Shows how add performance scales with collection size

### 3. `BM_RemoveAgentFromBeginning`
- **Purpose**: Measures performance of removing the first agent from the collection
- **Range**: Tests with 10 to 10,000 agents
- **Insight**: Worst-case scenario for vector-based removal

### 4. `BM_RemoveAgentFromMiddle`
- **Purpose**: Measures performance of removing an agent from the middle of the collection
- **Range**: Tests with 10 to 10,000 agents
- **Insight**: Average-case performance for vector-based removal

### 5. `BM_RemoveAgentFromEnd`
- **Purpose**: Measures performance of removing the last agent from the collection
- **Range**: Tests with 10 to 10,000 agents
- **Insight**: Best-case scenario for vector-based removal

### 6. `BM_RemoveNonExistentAgent`
- **Purpose**: Measures performance when trying to remove an agent that doesn't exist
- **Range**: Tests with 10 to 10,000 agents
- **Insight**: Performance of search operation for non-existent elements

### 7. `BM_AddAndRemoveSequential`
- **Purpose**: Measures mixed add/remove operations (removes every 3rd agent)
- **Range**: Tests with 10 to 1,000 operations
- **Insight**: Real-world usage patterns

### 8. `BM_AddManyAgentsLarge`
- **Purpose**: Measures performance with large datasets
- **Range**: Tests with 100 to 100,000 agents
- **Time Unit**: Milliseconds
- **Insight**: Scalability for large collections

## Building

To build with benchmarks enabled:

```bash
cd cmake-build-debug (or your preferred build directory)
cmake -DENABLE_BENCHMARKS=ON ..
cmake --build . --target app_benchmarks
```

## Running Benchmarks

### Run all benchmarks:
```bash
./benchmarks/app_benchmarks
```

### Run specific benchmark:
```bash
./benchmarks/app_benchmarks --benchmark_filter="BM_AddMultipleAgents"
```

### Output results to a file:
```bash
./benchmarks/app_benchmarks --benchmark_out=results.json --benchmark_out_format=json
```

### Run with specific number of iterations:
```bash
./benchmarks/app_benchmarks --benchmark_min_time=2 --benchmark_repetitions=5
```

## Benchmark Interpretation

- **Time**: Lower is better
- **Items processed**: Higher is better (when applicable)
- **Iterations**: Number of times the benchmark was run

## Performance Tips

For best results:

1. Build in **Release mode** for production-like performance:
   ```bash
   cmake -DCMAKE_BUILD_TYPE=Release -DENABLE_BENCHMARKS=ON ..
   ```

2. Close unnecessary applications to reduce system noise

3. Run multiple times with `--benchmark_repetitions=N` for more stable results

## Dependencies

- Google Benchmark v1.8.3 (automatically fetched via CMake FetchContent)
- C++23 compatible compiler

## Further Reading

- [Google Benchmark Documentation](https://github.com/google/benchmark/wiki)
- For detailed results analysis, export to JSON and use benchmark analysis tools
