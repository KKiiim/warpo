#pragma once

#include <filesystem>

namespace warpo {

void ensureFileDirectory(const std::filesystem::path &filePath);
void ensureDirectory(const std::filesystem::path &dirPath);

std::string getBaseName(std::filesystem::path const &path);

} // namespace warpo
