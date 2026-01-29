# -------------------------------------------------
# CompilerRuntime.cmake
# -------------------------------------------------

function(enable_project_runtime target)
  if(NOT TARGET ${target})
    message(FATAL_ERROR "Target ${target} does not exist")
  endif()

  # Only relevant for MSVC
  if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    # Default: DLL runtime (/MD, /MDd)
    if(USE_MSVC_RUNTIME_DLL)
      set_property(
        TARGET ${target} PROPERTY MSVC_RUNTIME_LIBRARY
                                  "MultiThreaded$<$<CONFIG:Debug>:Debug>DLL")
    else()
      # Static runtime (/MT, /MTd)
      set_property(
        TARGET ${target} PROPERTY MSVC_RUNTIME_LIBRARY
                                  "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    endif()
  endif()
endfunction()
