#pragma once
#ifndef CATA_SRC_WORLD_IDENTITY_STORE_H
#define CATA_SRC_WORLD_IDENTITY_STORE_H

#include "world_identity.h"

class cata_path;

inline constexpr const char *WORLD_IDENTITY_FILE = "world_identity.json";

// Read existing identity or atomically migrate a legacy writable world folder.
// Never replace a malformed/unknown identity or publish one before persistence.
// Concurrent/interrupted creation fails closed while its .creating lock exists.
world_id load_or_create_world_identity( const cata_path &world_directory );

#endif // CATA_SRC_WORLD_IDENTITY_STORE_H
