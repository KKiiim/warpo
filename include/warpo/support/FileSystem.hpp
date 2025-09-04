#pragma once

#include <filesystem>

namespace warpo {

void ensureFileDirectory(const std::filesystem::path &filePath);
void ensureDirectory(const std::filesystem::path &dirPath);

std::string getBaseName(std::filesystem::path const &path);

std::filesystem::path replaceExtension(std::filesystem::path const &path, std::filesystem::path const &newExt);

std::string readTextFile(std::string const &path);

std::string readBinaryFile(std::string const &path);

void writeBinaryFile(std::string const &path, std::string data);

} // namespace warpo
