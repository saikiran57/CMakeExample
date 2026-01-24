/**
 * @file agent_data.hpp
 * @author Saikiran Nadipilli (saikirannadipilli@gmail.com)
 * @brief
 * @version 0.1
 * @date 2026-01-23
 *
 * @copyright Copyright (c) 2026
 *
 */

#pragma once

#include "person.hpp"
#include <vector>

/**
 * @class agent_data
 * @brief Container class for managing a collection of agents.
 *
 * Provides functionality to store and manage multiple agent objects.
 * Supports adding new agents and removing agents by their ID.
 */
class agent_data
{
public:
    /**
     * @brief Default constructor.
     *
     * Initializes an empty agent_data container.
     */
    agent_data() = default;

    /**
     * @brief Adds a new agent to the collection.
     *
     * @param myagent The agent object to be added to the container.
     */
    void add(agent myagent);

    /**
     * @brief Removes an agent from the collection by its ID.
     *
     * @param id The unique identifier of the agent to be removed.
     */
    void remove(int id);

private:
    std::vector<agent> m_agents;  ///< Container storing all managed agents.
};