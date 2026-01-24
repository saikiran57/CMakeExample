# -------------------------------------------------
# CompilerDefinitions.cmake
# -------------------------------------------------

function(set_project_compile_definitions TARGET_NAME)

  if(NOT TARGET ${TARGET_NAME})
    message(FATAL_ERROR "Target '${TARGET_NAME}' does not exist")
  endif()

  target_compile_definitions(
    ${TARGET_NAME}
    PRIVATE # Build type
            $<$<CONFIG:Debug>:DEBUG_BUILD>
            $<$<CONFIG:Release>:NDEBUG>
            # Platform
            $<$<PLATFORM_ID:Windows>:PLATFORM_WINDOWS>
            $<$<PLATFORM_ID:Linux>:PLATFORM_LINUX>
            $<$<PLATFORM_ID:Darwin>:PLATFORM_MACOS>
            # Compiler
            $<$<CXX_COMPILER_ID:MSVC>:COMPILER_MSVC>
            $<$<CXX_COMPILER_ID:GNU>:COMPILER_GCC>
            $<$<CXX_COMPILER_ID:Clang>:COMPILER_CLANG>
            # Feature toggles (read from cache options)
            $<$<BOOL:${ENABLE_LOGGING}>:ENABLE_LOGGING>
            $<$<BOOL:${ENABLE_EXCEPTIONS}>:ENABLE_EXCEPTIONS>)

endfunction()
