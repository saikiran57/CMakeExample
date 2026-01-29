include_guard(GLOBAL)

option(ENABLE_ASAN "Enable AddressSanitizer" OFF)
option(ENABLE_TSAN "Enable ThreadSanitizer" OFF)
option(ENABLE_UBSAN "Enable UndefinedBehaviorSanitizer" OFF)

# ---------------- Internal helpers ----------------
function(_check_target target)
  if(NOT TARGET ${target})
    message(FATAL_ERROR "Sanitizers: Target '${target}' does not exist")
  endif()
endfunction()

function(_check_build_type_or_fail)
  if(NOT CMAKE_BUILD_TYPE MATCHES "Debug|RelWithDebInfo")
    message(
      FATAL_ERROR
        "Sanitizers are enabled but build type is '${CMAKE_BUILD_TYPE}'. Only Debug or RelWithDebInfo is allowed!"
    )
  endif()
endfunction()

function(_check_sanitizer_combos)
  if(ENABLE_ASAN AND ENABLE_TSAN)
    message(FATAL_ERROR "ASan and TSan cannot be enabled together.")
  endif()

  if(ENABLE_TSAN AND ENABLE_UBSAN)
    message(FATAL_ERROR "TSan and UBSan cannot be enabled together.")
  endif()
endfunction()

# ---------------- Apply flags ----------------
function(_apply_common_flags target)
  target_compile_options(${target} PRIVATE -fno-omit-frame-pointer
                                           -fno-optimize-sibling-calls)
endfunction()

function(_apply_asan target)
  target_compile_options(${target} PRIVATE -fsanitize=address)
  target_link_options(${target} PRIVATE -fsanitize=address)
  _apply_common_flags(${target})
endfunction()

function(_apply_ubsan target)
  target_compile_options(${target} PRIVATE -fsanitize=undefined
                                           -fno-sanitize-recover=undefined)
  target_link_options(${target} PRIVATE -fsanitize=undefined)
endfunction()

function(_apply_tsan target)
  if(NOT MSVC)
    target_compile_options(${target} PRIVATE -fsanitize=thread)
    target_link_options(${target} PRIVATE -fsanitize=thread)
  endif()
endfunction()

function(_apply_asan_ubsan target)
  target_compile_options(${target} PRIVATE -fsanitize=address,undefined
                                           -fno-sanitize-recover=undefined)
  target_link_options(${target} PRIVATE -fsanitize=address,undefined)
  _apply_common_flags(${target})
endfunction()

# ---------------- Public API ----------------
function(enable_sanitizers target)
  _check_target(${target})
  _check_build_type_or_fail()
  _check_sanitizer_combos()

  # ---------------- MSVC ----------------
  if(MSVC)
    if(ENABLE_ASAN)
      message(STATUS "Enabling MSVC AddressSanitizer for ${target}")
      target_compile_options(${target} PRIVATE /fsanitize=address)
      target_link_options(${target} PRIVATE /INCREMENTAL:NO)
    endif()

    if(ENABLE_TSAN)
      message(
        WARNING "ThreadSanitizer not supported on MSVC. Ignoring ENABLE_TSAN.")
    endif()

    if(ENABLE_UBSAN)
      message(
        WARNING
          "UndefinedBehaviorSanitizer not supported on MSVC. Ignoring ENABLE_UBSAN."
      )
    endif()
    return()
  endif()

  # ---------------- GCC / Clang ----------------
  if(ENABLE_ASAN AND ENABLE_UBSAN)
    message(STATUS "Enabling ASan + UBSan for ${target}")
    _apply_asan_ubsan(${target})
  elseif(ENABLE_ASAN)
    message(STATUS "Enabling ASan for ${target}")
    _apply_asan(${target})
  elseif(ENABLE_UBSAN)
    message(STATUS "Enabling UBSan for ${target}")
    _apply_ubsan(${target})
  endif()

  if(ENABLE_TSAN)
    message(STATUS "Enabling TSan for ${target}")
    _apply_tsan(${target})
  endif()
endfunction()
