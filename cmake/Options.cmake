# cmake/Options.cmake
include_guard(GLOBAL)

# -------------------------------------------------
# Build features
# -------------------------------------------------
option(ENABLE_APP "Build application executable" ON)
option(ENABLE_TESTS "Build unit tests" OFF)
option(ENABLE_BENCHMARKS "Build benchmarks" OFF)

# -------------------------------------------------
# Tooling & diagnostics
# -------------------------------------------------
option(ENABLE_WARNINGS "Enable compiler warnings" ON)
option(ENABLE_SANITIZERS "Enable sanitizers" OFF)
option(ENABLE_ASAN "Enable AddressSanitizer" OFF)
option(ENABLE_TSAN "Enable ThreadSanitizer" OFF)
option(ENABLE_UBSAN "Enable UndefinedBehaviorSanitizer" OFF)

# -------------------------------------------------
# Build speed
# -------------------------------------------------
option(ENABLE_PCH "Enable precompiled headers" ON)
option(ENABLE_UNITY_BUILD "Enable unity/jumbo builds" OFF)
option(ENABLE_COMPILER_CACHE "Enable ccache/sccache" ON)
option(ENABLE_FAST_LINKER "Use faster linker (lld)" ON)
option(ENABLE_INCREMENTAL_LINK "Enable incremental linking" ON)

# -------------------------------------------------
# Platform / compiler behavior
# -------------------------------------------------
option(ENABLE_SDL "Enable MSVC SDL security checks" OFF)
option(USE_MSVC_RUNTIME_DLL "Use MSVC runtime DLL (/MD)" ON)
option(ENABLE_EXCEPTIONS "Enable C++ exceptions" ON)
option(ENABLE_LOGGING "Enable logging support" ON)
