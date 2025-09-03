set(CMAKE_CXX_STANDARD 26) # use c++ 26 to embed binary file

if(WARPO_RELEASE)
  set(AS_BUILD_TARGET release)
else()
  set(AS_BUILD_TARGET debug)
endif()

message("build assemblyscript target: ${AS_BUILD_TARGET}")

file(GLOB_RECURSE asc_sources
  "${PROJECT_SOURCE_DIR}/assemblyscript/src/*.ts"
  "${PROJECT_SOURCE_DIR}/assemblyscript/std/*.ts"
  "${PROJECT_SOURCE_DIR}/assemblyscript/scripts/*.js"
)

# Ensure the build-as directory exists
file(MAKE_DIRECTORY ${PROJECT_SOURCE_DIR}/build-as)
add_custom_command(
  COMMENT "Build ASC<${AS_BUILD_TARGET}> to WASM"
  OUTPUT ${PROJECT_SOURCE_DIR}/build-as/assemblyscript.inc ${PROJECT_SOURCE_DIR}/build-as/library_sources.inc
  DEPENDS ${asc_sources} ${CMAKE_CURRENT_SOURCE_DIR}/gen.mjs ${PROJECT_SOURCE_DIR}/asconfig.json
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}

  COMMAND node
  ARGS gen.mjs ${AS_BUILD_TARGET}
)

add_custom_target(warpo_frontend_asc_wasm_hpp ALL DEPENDS ${PROJECT_SOURCE_DIR}/build-as/assemblyscript.inc ${PROJECT_SOURCE_DIR}/build-as/library_sources.inc)

aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} warpo_frontend_asc_sources)

add_library(warpo_frontend_asc ${warpo_frontend_asc_sources})
add_dependencies(warpo_frontend_asc warpo_frontend_asc_wasm_hpp)
target_include_directories(warpo_frontend_asc PRIVATE ${PROJECT_SOURCE_DIR}/build-as)
