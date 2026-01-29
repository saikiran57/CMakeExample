# ============================================================
# TargetSetup.cmake — Configure individual targets
# ============================================================

include_guard(GLOBAL)

function(configure_target TARGET_NAME)
  if(NOT TARGET ${TARGET_NAME})
    message(FATAL_ERROR "TargetSetup: Target '${TARGET_NAME}' does not exist")
  endif()

  # ---------------- Compiler definitions ----------------
  set_project_compile_definitions(${TARGET_NAME})
  message(STATUS "TargetSetup: Applied compile definitions to '${TARGET_NAME}'")

  # ---------------- FastBuild optimizations ----------------
  enable_fast_build(${TARGET_NAME})
  message(
    STATUS "TargetSetup: Applied FastBuild optimizations to '${TARGET_NAME}'")

  # ---------------- Sanitizers ----------------
  enable_sanitizers(${TARGET_NAME})
  message(STATUS "TargetSetup: Applied Sanitizers to '${TARGET_NAME}'")

  # Optional summary
  message(STATUS "TargetSetup: Target '${TARGET_NAME}' fully configured")
endfunction()
