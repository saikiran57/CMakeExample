/**
 * @file agent_data_benchmark.cpp
 * @author Saikiran Nadipilli (saikirannadipilli@gmail.com)
 * @brief Benchmark tests for agent_data class
 * @version 0.1
 * @date 2026-01-23
 *
 * @copyright Copyright (c) 2026
 */

#include "agent_data.hpp"
#include "person.hpp"
#include <benchmark/benchmark.h>

/**
 * @brief Benchmark: Adding single agent to empty agent_data
 */
static void BM_AddSingleAgent(benchmark::State& state)
{
    for (auto _ : state)
    {
        agent_data data;
        agent test_agent;
        test_agent.m_id = 1;
        test_agent.m_name = "Agent 1";
        data.add(test_agent);
    }
}
BENCHMARK(BM_AddSingleAgent);

/**
 * @brief Benchmark: Adding multiple agents sequentially
 */
static void BM_AddMultipleAgents(benchmark::State& state)
{
    int num_agents = state.range(0);

    for (auto _ : state)
    {
        agent_data data;
        for (int i = 0; i < num_agents; ++i)
        {
            agent test_agent;
            test_agent.m_id = i;
            test_agent.m_name = "Agent " + std::to_string(i);
            data.add(test_agent);
        }
    }
}
BENCHMARK(BM_AddMultipleAgents)->Range(10, 10000);

/**
 * @brief Benchmark: Removing agent from beginning of collection
 */
static void BM_RemoveAgentFromBeginning(benchmark::State& state)
{
    int num_agents = state.range(0);

    for (auto _ : state)
    {
        agent_data data;

        // Setup: Add agents
        for (int i = 0; i < num_agents; ++i)
        {
            agent test_agent;
            test_agent.m_id = i;
            test_agent.m_name = "Agent " + std::to_string(i);
            data.add(test_agent);
        }

        // Benchmark: Remove the first agent
        state.PauseTiming();
        state.ResumeTiming();
        data.remove(0);
    }
}
BENCHMARK(BM_RemoveAgentFromBeginning)->Range(10, 10000);

/**
 * @brief Benchmark: Removing agent from middle of collection
 */
static void BM_RemoveAgentFromMiddle(benchmark::State& state)
{
    int num_agents = state.range(0);
    int middle_id = num_agents / 2;

    for (auto _ : state)
    {
        agent_data data;

        // Setup: Add agents
        for (int i = 0; i < num_agents; ++i)
        {
            agent test_agent;
            test_agent.m_id = i;
            test_agent.m_name = "Agent " + std::to_string(i);
            data.add(test_agent);
        }

        // Benchmark: Remove the middle agent
        state.PauseTiming();
        state.ResumeTiming();
        data.remove(middle_id);
    }
}
BENCHMARK(BM_RemoveAgentFromMiddle)->Range(10, 10000);

/**
 * @brief Benchmark: Removing agent from end of collection
 */
static void BM_RemoveAgentFromEnd(benchmark::State& state)
{
    int num_agents = state.range(0);
    int last_id = num_agents - 1;

    for (auto _ : state)
    {
        agent_data data;

        // Setup: Add agents
        for (int i = 0; i < num_agents; ++i)
        {
            agent test_agent;
            test_agent.m_id = i;
            test_agent.m_name = "Agent " + std::to_string(i);
            data.add(test_agent);
        }

        // Benchmark: Remove the last agent
        state.PauseTiming();
        state.ResumeTiming();
        data.remove(last_id);
    }
}
BENCHMARK(BM_RemoveAgentFromEnd)->Range(10, 10000);

/**
 * @brief Benchmark: Removing non-existent agent
 */
static void BM_RemoveNonExistentAgent(benchmark::State& state)
{
    int num_agents = state.range(0);

    for (auto _ : state)
    {
        agent_data data;

        // Setup: Add agents
        for (int i = 0; i < num_agents; ++i)
        {
            agent test_agent;
            test_agent.m_id = i;
            test_agent.m_name = "Agent " + std::to_string(i);
            data.add(test_agent);
        }

        // Benchmark: Try to remove non-existent agent
        state.PauseTiming();
        state.ResumeTiming();
        data.remove(999999);  // ID that doesn't exist
    }
}
BENCHMARK(BM_RemoveNonExistentAgent)->Range(10, 10000);

/**
 * @brief Benchmark: Multiple sequential add and remove operations
 */
static void BM_AddAndRemoveSequential(benchmark::State& state)
{
    int num_operations = state.range(0);

    for (auto _ : state)
    {
        agent_data data;

        for (int i = 0; i < num_operations; ++i)
        {
            agent test_agent;
            test_agent.m_id = i;
            test_agent.m_name = "Agent " + std::to_string(i);
            data.add(test_agent);

            // Remove every 3rd agent
            if (i > 0 && i % 3 == 0)
            {
                data.remove(i - 1);
            }
        }
    }
}
BENCHMARK(BM_AddAndRemoveSequential)->Range(10, 1000);

/**
 * @brief Benchmark: Creation and addition of many agents
 */
static void BM_AddManyAgentsLarge(benchmark::State& state)
{
    int num_agents = state.range(0);

    for (auto _ : state)
    {
        agent_data data;
        for (int i = 0; i < num_agents; ++i)
        {
            agent test_agent;
            test_agent.m_id = i;
            test_agent.m_name = "Agent_" + std::to_string(i);
            data.add(std::move(test_agent));
        }
    }
}
BENCHMARK(BM_AddManyAgentsLarge)->Range(100, 100000)->Unit(benchmark::kMillisecond);
