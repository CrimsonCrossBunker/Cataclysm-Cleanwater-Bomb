#pragma once
#ifndef CATA_SRC_ANDROID_STORAGE_H
#define CATA_SRC_ANDROID_STORAGE_H

#include <string>

void migrate_legacy_android_user_data( const std::string &legacy_user_dir,
                                       const std::string &user_dir );

#endif // CATA_SRC_ANDROID_STORAGE_H

