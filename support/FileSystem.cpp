#include <filesystem>
#include <fmt/format.h>
#include <stdexcept>

#include "warpo/support/FileSystem.hpp"

namespace warpo {

void ensureFileDirectory(const std::filesystem::path &filePath) {
  std::filesystem::path dirPath = filePath.parent_path();
  ensureDirectory(dirPath);
}

void ensureDirectory(const std::filesystem::path &dirPath) {
  if (std::filesystem::exists(dirPath)) {
    if (!std::filesystem::is_directory(dirPath)) {
      throw std::runtime_error(fmt::format("Path '{}' exists and is not a directory", dirPath.string()));
    }
  }
  std::error_code ec;
  std::filesystem::create_directories(dirPath, ec);
  if (ec) {
    throw std::runtime_error(
        fmt::format("Failed to create directories for path '{}': {}", dirPath.string(), ec.message()));
  }
}

} // namespace warpo
