#pragma once

#include "person.hpp"
#include <vector>

class agent_data
{
public:
    agent_data() = default;
    void add(agent myagent);
    void remove(int id);

private:
    std::vector<agent> m_agents;
};