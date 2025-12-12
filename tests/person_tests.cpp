#include "agent_data.hpp"
#include "person.hpp"
#include "gtest/gtest.h"

TEST(agent_tests, test1)
{
    person p1{.m_id = 1, .m_name = "Test"};
    person p2{.m_id = 1, .m_name = "Test"};
    EXPECT_TRUE(p1 == p2);
}

TEST(agent_tests, add_agent)
{
    agent myagent;
    myagent.m_id = 1;
    myagent.m_name = "Tesst";

    agent_data data;
    data.add(myagent);
    data.remove(1);
}