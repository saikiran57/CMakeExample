/**
 * @file agent_data.cpp
 * @author Saikiran Nadipilli (saikirannadipilli@gmail.com)
 * @brief
 * @version 0.1
 * @date 2026-01-23
 *
 * @copyright Copyright (c) 2026
 *
 */

#include "agent_data.hpp"
#include <algorithm>

void agent_data::add(agent myagent)
{
    m_agents.emplace_back(std::move(myagent));
}

void agent_data::remove(int id)
{
    auto it = std::find_if(m_agents.begin(), m_agents.end(), [id](const agent& myagent) {
        return myagent.m_id == id;
    });

    if (it != m_agents.end())
    {
        m_agents.erase(it);
    }
}
