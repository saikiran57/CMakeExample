# -------------------------------------------------
# CompilerWarnings.cmake
# -------------------------------------------------

function(enable_project_warnings target)
  if(NOT TARGET ${target})
    message(FATAL_ERROR "Target ${target} does not exist")
  endif()

  # ===================== MSVC =====================
  if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    target_compile_options(
      ${target}
      PRIVATE /W4
              /permissive-
              /Zc:__cplusplus
              /Zc:preprocessor
              /EHsc
              # High-signal warnings
              /w14263 # 'override' correctness
              # Noise suppression (DLL boundaries)
              /wd4251 # STL in exported classes
              /wd4275 # DLL interface inheritance
              /wd4996 # Deprecated CRT
    )

    # Security Development Lifecycle checks
    if(ENABLE_SDL)
      target_compile_options(${target} PRIVATE /sdl)
    endif()

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
              -Wconversion
              -Wsign-conversion
              -Wshadow
              -Wnull-dereference
              -Wdouble-promotion
              -Wformat=2
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
              -Wconversion
              -Wsign-conversion
              -Wshadow
              -Wnull-dereference
              -Wdouble-promotion
              -Wformat=2
              -Wimplicit-fallthrough
              -Wno-unknown-warning-option
              -Wno-missing-field-initializers)

    if(ENABLE_WERROR)
      target_compile_options(${target} PRIVATE -Werror)
    endif()
  endif()
endfunction()
