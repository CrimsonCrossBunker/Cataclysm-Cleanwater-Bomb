#pragma once
#ifndef CATA_SRC_NATIVE_FILE_PATH_H
#define CATA_SRC_NATIVE_FILE_PATH_H

#include <filesystem>

std::filesystem::path native_file_path( const std::filesystem::path &path,
                                        bool allow_long_children = false );

#endif // CATA_SRC_NATIVE_FILE_PATH_H
