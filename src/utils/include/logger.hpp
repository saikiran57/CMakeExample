/**
 * @file logger.hpp
 * @author Saikiran Nadipilli (saikirannadipilli@gmail.com)
 * @brief
 * @version 0.1
 * @date 2026-01-26
 *
 * @copyright Copyright (c) 2026
 *
 */

#pragma once

#define log_info(message) std::cout << "info:" << message << "\n";
#define log_warn(message) std::cout << "warn:" << message << "\n";
#define log_err(message) std::cout << "err:" << message << "\n";