add_library(warp_runner
  warpRunner.cpp
)

target_link_libraries(warp_runner
  PUBLIC vb_libWasmModule
)
add_dependencies(warp_runner vb_libWasmModule)
