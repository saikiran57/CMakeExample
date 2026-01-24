# -------------------------------------------------
# CompilerWarnings.cmake
# -------------------------------------------------

function(enable_project_warnings target)

  if(NOT TARGET ${target})
    message(FATAL_ERROR "Target ${target} does not exist")
  endif()

  # ===================== MSVC =====================
  if(MSVC)
    target_compile_options(
      ${target}
      PRIVATE /W4 # High warning level (readable)
              /permissive- # Standards conformance
              /Zc:__cplusplus # Correct __cplusplus value
              /Zc:preprocessor # Modern preprocessor
              # Noise suppression
              /wd4251 # DLL interface
              /wd4275 # DLL inheritance
              /wd4996 # Deprecated CRT
    )

    if(ENABLE_WERROR)
      target_compile_options(${target} PRIVATE /WX)
    endif()

    # ===================== GCC ======================
  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    target_compile_options(
      ${target}
      PRIVATE -Wall
              -Wextra
              -Wpedantic
              # High-signal warnings
              -Wconversion
              -Wsign-conversion
              -Wshadow
              -Wnull-dereference
              -Wdouble-promotion
              -Wformat=2
              # Reduce noise
              -Wno-missing-field-initializers
              -Wno-unknown-pragmas)

    if(ENABLE_WERROR)
      target_compile_options(${target} PRIVATE -Werror)
    endif()

    # ===================== Clang ====================
  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    target_compile_options(
      ${target}
      PRIVATE -Wall
              -Wextra
              -Wpedantic
              # High-signal warnings (clang excels here)
              -Wconversion
              -Wsign-conversion
              -Wshadow
              -Wnull-dereference
              -Wdouble-promotion
              -Wformat=2
              -Wimplicit-fallthrough
              # Reduce clang-specific noise
              -Wno-unknown-warning-option
              -Wno-missing-field-initializers)

    if(ENABLE_WERROR)
      target_compile_options(${target} PRIVATE -Werror)
    endif()
  endif()

endfunction()
