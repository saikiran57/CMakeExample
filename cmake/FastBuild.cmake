# ============================================================
# FastBuild.cmake Build-speed optimizations (PCH, cache, unity, linker)
# ============================================================

include_guard(GLOBAL)

# ------------------------------------------------------------
# Options (Preset-controlled)
# ------------------------------------------------------------
option(ENABLE_PCH "Enable precompiled headers" ON)
option(ENABLE_UNITY_BUILD "Enable unity/jumbo builds" OFF)
option(ENABLE_COMPILER_CACHE "Enable ccache/sccache" ON)
option(ENABLE_FAST_LINKER "Use faster linker (lld)" ON)
option(ENABLE_PARALLEL_COMPILE "Enable parallel compilation flags" ON)
option(ENABLE_INCREMENTAL_LINK "Enable incremental linking (MSVC)" ON)

# ------------------------------------------------------------
# Compiler cache
# ------------------------------------------------------------
if(ENABLE_COMPILER_CACHE)
  find_program(CCACHE_PROGRAM ccache)
  find_program(SCCACHE_PROGRAM sccache)

  if(CCACHE_PROGRAM)
    message(STATUS "FastBuild: Using ccache")
    set(CMAKE_C_COMPILER_LAUNCHER ccache)
    set(CMAKE_CXX_COMPILER_LAUNCHER ccache)
  elseif(SCCACHE_PROGRAM)
    message(STATUS "FastBuild: Using sccache")
    set(CMAKE_C_COMPILER_LAUNCHER sccache)
    set(CMAKE_CXX_COMPILER_LAUNCHER sccache)
  endif()
endif()

# ------------------------------------------------------------
# Fast linker
# ------------------------------------------------------------
if(ENABLE_FAST_LINKER AND NOT MSVC)
  include(CheckLinkerFlag)
  check_linker_flag(CXX "-fuse-ld=lld" HAS_LLD)
  if(HAS_LLD)
    add_link_options(-fuse-ld=lld)
  endif()
endif()

# ------------------------------------------------------------
# Parallel compilation
# ------------------------------------------------------------
if(ENABLE_PARALLEL_COMPILE AND MSVC)
  add_compile_options(/MP)
endif()

# ------------------------------------------------------------
# Function: enable_fast_build(target)
# ------------------------------------------------------------
function(enable_fast_build target)
  if(NOT TARGET ${target})
    message(FATAL_ERROR "FastBuild: Target '${target}' does not exist")
  endif()

  # --------------------------------------------------------
  # Precompiled Header (pch.hpp)
  # --------------------------------------------------------
  if(ENABLE_PCH)
    set(PCH_HEADER "${CMAKE_CURRENT_SOURCE_DIR}/include/pch.hpp")

    if(NOT EXISTS "${PCH_HEADER}")
      message(
        FATAL_ERROR
          "FastBuild: ENABLE_PCH is ON but pch.hpp not found at:\n  ${PCH_HEADER}"
      )
    endif()

    message(STATUS "FastBuild: Using PCH for ${target}: ${PCH_HEADER}")

    target_precompile_headers(${target} PRIVATE "${PCH_HEADER}")

    # Detect broken PCH usage
    if(NOT MSVC)
      target_compile_options(${target} PRIVATE -Winvalid-pch)
    endif()
  endif()

  # --------------------------------------------------------
  # Unity builds (CI-friendly)
  # --------------------------------------------------------
  if(ENABLE_UNITY_BUILD)
    set_target_properties(${target} PROPERTIES UNITY_BUILD ON
                                               UNITY_BUILD_BATCH_SIZE 8)
  endif()

  # --------------------------------------------------------
  # Incremental linking
  # --------------------------------------------------------
  if(ENABLE_INCREMENTAL_LINK AND MSVC)
    target_link_options(${target} PRIVATE /INCREMENTAL)
  endif()

  # --------------------------------------------------------
  # Compiler speed flags
  # --------------------------------------------------------
  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    target_compile_options(${target} PRIVATE -pipe -fno-omit-frame-pointer)
  endif()

endfunction()
