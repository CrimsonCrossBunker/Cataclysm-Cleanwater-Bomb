#pragma once
#ifndef CATA_SRC_IDENTITY_RANDOM_H
#define CATA_SRC_IDENTITY_RANDOM_H

#include <cstddef>
#include <string>

// Persistent identity material from the OS, never from the simulation RNG.
// Throws on entropy failure; callers must persist before publishing an identity.
std::string random_identity_hex( size_t byte_count );

#endif // CATA_SRC_IDENTITY_RANDOM_H
