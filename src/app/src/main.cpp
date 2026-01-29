#include "person.hpp"
#include <iostream>

#define log_info(message) std::cout << "info:" << message << "\n";
#define log_warn(message) std::cout << "warn:" << message << "\n";
#define log_err(message) std::cout << "err:" << message << "\n";

int main()
{
    person p1{.m_id = 1, .m_name = "Test"};
    person p2{.m_id = 1, .m_name = "Test"};

    log_info("my first log");

    std::cout << std::boolalpha << (p1 == p2) << "\n";

    func(12);

#ifdef DEBUG_BUILD
    int i = 0;
    while (true)
    {
        std::cout << i << "\n";
        ++i;
        sleep(1);
    }
#else
    std::cout << "feature is disabled\n";
#endif

#ifdef DEBUG_MODE
    std::cout << "debug mode\n";
#else
    std::cout << "no debug mode\n";
#endif

    return 0;
}