#pragma once

// ================= Standard Library =================
#include <algorithm>
#include <array>
#include <atomic>
#include <chrono>
#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <functional>
#include <future>
#include <initializer_list>
#include <iostream>
#include <limits>
#include <map>
#include <memory>
#include <mutex>
#include <optional>
#include <queue>
#include <set>
#include <span>
#include <string>
#include <string_view>
#include <thread>
#include <tuple>
#include <type_traits>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>

// ================= Platform / Compiler =================
#ifdef _WIN32
#include <windows.h>
#endif

// ================= Project-wide headers =================
// Keep these VERY stable
// #include "config.hpp"
// #include "logging.hpp"

// ❗ Rules:
// - No frequently changing headers
// - No macros with side effects
// - No heavy templates unless unavoidable
