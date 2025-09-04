add_executable(warpo_frontend_test
  FrontendTest.cpp
)

target_link_libraries(warpo_frontend_test
  PRIVATE warpo_frontend
)
target_include_directories(warpo_frontend_test
  SYSTEM PRIVATE "${PROJECT_SOURCE_DIR}/third_party/binaryen/src"
)
