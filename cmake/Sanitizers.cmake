include_guard(GLOBAL)

# Options (normally enabled via presets)
option(ENABLE_ASAN "Enable AddressSanitizer" OFF)
option(ENABLE_TSAN "Enable ThreadSanitizer" OFF)
option(ENABLE_UBSAN "Enable UndefinedBehaviorSanitizer" OFF)

# ------------------------------------------------------------
# Internal validation
# ------------------------------------------------------------
if(ENABLE_TSAN AND ENABLE_ASAN)
  message(FATAL_ERROR "ASAN and TSAN cannot be enabled together")
endif()

if(MSVC AND (ENABLE_TSAN OR ENABLE_UBSAN))
  message(WARNING "TSAN/UBSAN are not supported on MSVC")
endif()

# ------------------------------------------------------------
# Helper: apply sanitizer flags
# ------------------------------------------------------------
function(_apply_sanitizer_flags target sanitizer)
  target_compile_options(${target} PRIVATE -fsanitize=${sanitizer})
  target_link_options(${target} PRIVATE -fsanitize=${sanitizer})
endfunction()

# ------------------------------------------------------------
# Public API
# ------------------------------------------------------------
function(enable_sanitizers target)
  if(MSVC)
    if(ENABLE_ASAN)
      message(STATUS "Enabling MSVC AddressSanitizer for ${target}")
      target_compile_options(${target} PRIVATE /fsanitize=address)
      target_link_options(${target} PRIVATE /INCREMENTAL:NO)
    endif()
    return()
  endif()

  if(ENABLE_ASAN)
    message(STATUS "Enabling AddressSanitizer for ${target}")
    _apply_sanitizer_flags(${target} address)
  endif()

  if(ENABLE_TSAN)
    message(STATUS "Enabling ThreadSanitizer for ${target}")
    _apply_sanitizer_flags(${target} thread)
  endif()

  if(ENABLE_UBSAN)
    message(STATUS "Enabling UndefinedBehaviorSanitizer for ${target}")
    _apply_sanitizer_flags(${target} undefined)
  endif()
endfunction()
