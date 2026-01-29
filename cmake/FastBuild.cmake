# ============================================================
# FastBuild.cmake — Cross-compiler build speed optimizations MSVC (Ninja/VS),
# GCC, Clang
# ============================================================

include_guard(GLOBAL)

# ------------------------------------------------------------
# Options (preset-controlled)
# ------------------------------------------------------------
option(ENABLE_PCH "Enable precompiled headers" ON)
option(ENABLE_UNITY_BUILD "Enable unity/jumbo builds" OFF)
option(ENABLE_COMPILER_CACHE "Enable ccache/sccache" ON)
option(ENABLE_FAST_LINKER "Use faster linker when available" ON)
option(ENABLE_INCREMENTAL_LINK "Enable incremental linking (MSVC)" ON)
option(ENABLE_PARALLEL_COMPILE "Enable compiler parallelism flags" ON)

# ------------------------------------------------------------
# Compiler cache (prefer sccache on Windows)
# ------------------------------------------------------------
if(ENABLE_COMPILER_CACHE)
  find_program(SCCACHE_PROGRAM sccache)
  find_program(CCACHE_PROGRAM ccache)

  if(SCCACHE_PROGRAM)
    message(STATUS "FastBuild: Using sccache")
    set(CMAKE_C_COMPILER_LAUNCHER sccache)
    set(CMAKE_CXX_COMPILER_LAUNCHER sccache)
  elseif(CCACHE_PROGRAM)
    message(STATUS "FastBuild: Using ccache")
    set(CMAKE_C_COMPILER_LAUNCHER ccache)
    set(CMAKE_CXX_COMPILER_LAUNCHER ccache)
  endif()
endif()

# ------------------------------------------------------------
# Fast linker (GCC / Clang only)
# ------------------------------------------------------------
if(ENABLE_FAST_LINKER AND NOT MSVC)
  include(CheckLinkerFlag)
  check_linker_flag(CXX "-fuse-ld=lld" HAS_LLD)

  if(HAS_LLD)
    add_link_options(-fuse-ld=lld)
  endif()
endif()

# ------------------------------------------------------------
# Function: enable_fast_build(target)
# ------------------------------------------------------------
function(enable_fast_build target)
  if(NOT TARGET ${target})
    message(FATAL_ERROR "FastBuild: Target '${target}' does not exist")
  endif()

  # --------------------------------------------------------
  # Precompiled headers (attach once, per-target)
  # --------------------------------------------------------
  if(ENABLE_PCH)
    get_target_property(_existing_pch ${target} PRECOMPILE_HEADERS)

    if(NOT _existing_pch)
      get_target_property(_incs ${target} INCLUDE_DIRECTORIES)
      list(LENGTH _incs _inc_count)

      if(_inc_count GREATER 0)
        list(GET _incs 0 _primary_inc)
        set(PCH_HEADER "${_primary_inc}/pch.hpp")

        if(EXISTS "${PCH_HEADER}")
          message(STATUS "FastBuild: Using PCH for ${target}: ${PCH_HEADER}")
          target_precompile_headers(${target} PRIVATE "${PCH_HEADER}")

          if(NOT MSVC)
            target_compile_options(${target} PRIVATE -Winvalid-pch)
          endif()
        endif()
      endif()
    endif()
  endif()

  # --------------------------------------------------------
  # MSVC (Ninja or VS)
  # --------------------------------------------------------
  if(MSVC)
    if(CMAKE_GENERATOR MATCHES "Ninja")
      # Use FS, Gy, Gw, /Z7 but skip /MP
      target_compile_options(${target} PRIVATE /FS /Gy /Gw
                                               $<$<CONFIG:Debug>:/Z7>)
    else()
      # MSBuild /VS: use /MP
      target_compile_options(${target} PRIVATE /MP /FS /Gy /Gw
                                               $<$<CONFIG:Debug>:/Z7>)
    endif()

    # Incremental linking (Debug-ish only)
    if(ENABLE_INCREMENTAL_LINK)
      target_link_options(${target} PRIVATE $<$<CONFIG:Debug>:/INCREMENTAL>
                          $<$<CONFIG:RelWithDebInfo>:/INCREMENTAL>)
    endif()
  endif()

  # --------------------------------------------------------
  # GCC
  # --------------------------------------------------------
  if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    if(ENABLE_PARALLEL_COMPILE)
      target_compile_options(${target} PRIVATE -pipe)
    endif()
  endif()

  # --------------------------------------------------------
  # Clang
  # --------------------------------------------------------
  if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    if(ENABLE_PARALLEL_COMPILE)
      target_compile_options(${target} PRIVATE -pipe)
    endif()
  endif()

  # --------------------------------------------------------
  # Unity builds (opt-in)
  # --------------------------------------------------------
  if(ENABLE_UNITY_BUILD)
    set_target_properties(${target} PROPERTIES UNITY_BUILD ON
                                               UNITY_BUILD_BATCH_SIZE 8)
  endif()
endfunction()
