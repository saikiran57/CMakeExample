#pragma once

#include <iostream>
#include <mutex>
#include <unistd.h>

static constexpr int GLOBAL_VALUE = 100;
using t_my_int = int32_t;

class person
{
public:
    int m_id;
    std::string m_name;
    auto operator<=>(const person&) const = default;

    static constexpr int VALUE = 100;
    static std::mutex s_mutex;
};

struct agent : public person
{
};

struct admin : public person
{
};

template <typename T>
inline void func(T arg)
{
    std::cout << arg << "\n";
}
