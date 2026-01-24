include_guard(GLOBAL)

option(ENABLE_CLANG_TIDY "Enable clang-tidy" OFF)
option(ENABLE_CPPCHECK "Enable cppcheck" OFF)
option(ENABLE_IWYU "Enable include-what-you-use" OFF)

# ------------------------------------------------------------
# clang-tidy (uses .clang-tidy file)
# ------------------------------------------------------------
if(ENABLE_CLANG_TIDY)
  find_program(CLANG_TIDY_EXE NAMES clang-tidy)

  if(CLANG_TIDY_EXE)
    message(STATUS "clang-tidy enabled: ${CLANG_TIDY_EXE}")

    # Do NOT specify checks here – .clang-tidy controls everything
    set(CMAKE_CXX_CLANG_TIDY ${CLANG_TIDY_EXE}; --quiet)
  else()
    message(WARNING "ENABLE_CLANG_TIDY=ON but clang-tidy not found")
  endif()
endif()

# ------------------------------------------------------------
# cppcheck
# ------------------------------------------------------------
if(ENABLE_CPPCHECK)
  find_program(CPPCHECK_EXE NAMES cppcheck)

  if(CPPCHECK_EXE)
    message(STATUS "cppcheck enabled: ${CPPCHECK_EXE}")

    set(CMAKE_CXX_CPPCHECK
        ${CPPCHECK_EXE}; --enable=warning,performance,portability;
        --inline-suppr; --suppress=missingIncludeSystem)
  else()
    message(WARNING "ENABLE_CPPCHECK=ON but cppcheck not found")
  endif()
endif()

# ------------------------------------------------------------
# include-what-you-use
# ------------------------------------------------------------
if(ENABLE_IWYU)
  find_program(IWYU_EXE NAMES include-what-you-use iwyu)

  if(IWYU_EXE)
    message(STATUS "include-what-you-use enabled: ${IWYU_EXE}")
    set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE ${IWYU_EXE})
  else()
    message(WARNING "ENABLE_IWYU=ON but include-what-you-use not found")
  endif()
endif()
